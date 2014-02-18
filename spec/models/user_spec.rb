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
end
