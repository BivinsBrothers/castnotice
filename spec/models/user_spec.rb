require "spec_helper"

describe User do
  it "requires a name" do
    user = build(:user, name: "")

    expect(user.save).to be_false
    expect(user).to have(1).error_on(:name)
  end

  it "requires terms of service on create" do
    user = build(:user, tos: "0")

    expect(user.save).to be_false
    expect(user).to have(1).error_on(:tos)

    user.tos = "1"

    expect(user.save).to be_true
  end

  it "does not require terms of service on update" do
    user = create(:user)
    user.name = "New Name"

    expect(user.save).to be_true
    expect(user.name).to eq("New Name")
  end

  it "requires parental information when under 18" do
    user = build(:user, birthday: 17.years.ago)

    expect(user.save).to be_false
    expect(user).to have(1).error_on(:parent_name)

    user.birthday = 19.years.ago

    expect(user.save).to be_true
  end
end
