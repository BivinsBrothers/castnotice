require "spec_helper"

describe User do
  it "requires a name" do
    user = build(:user, name: "")

    expect(user.save).to be_falsy
    expect(user.errors[:name].size).to eq(1)
  end

  it "requires terms of service on create" do
    user = build(:user, tos: "0")

    expect(user.save).to be_falsy
    expect(user.errors[:tos].size).to eq(1)

    user.tos = "1"

    expect(user.save).to be_truthy
  end

  it "does not require terms of service on update" do
    user = create(:user)
    user.name = "New Name"

    expect(user.save).to be_truthy
    expect(user.name).to eq("New Name")
  end

  it "requires parental information when under 18" do
    user = build(:user, birthday: 17.years.ago)

    expect(user.save).to be_falsy
    expect(user.errors[:parent_name].size).to eq(1)

    user.birthday = 19.years.ago

    expect(user.save).to be_truthy
  end

  it "scopes: talent mentors" do
    user = create(:user)
    mentor = create(:user, email: 'cba@example.com', mentor: true)
    mentor1 = create(:user, email: 'abc@example.com', mentor: true)

    expect(User.talent_mentors).to eq([mentor1, mentor])
  end
end
