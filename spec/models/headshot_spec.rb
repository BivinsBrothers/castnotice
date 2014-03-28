require "spec_helper"

describe Headshot do
  let(:user) { create(:user) }
  let!(:headshot) { create(:headshot, user: user) }
  let!(:headshot_as_background) { create(:headshot, user: user, is_background: true) }

  it "a user can have only one background image" do
    headshot.is_background = true

    expect(headshot.save).to be_false
    expect(headshot).to have(1).errors_on(:is_background)
    expect(headshot.reload.is_background).to be_false
  end

  describe "#set_as_background_image" do
    it "removes current background image if set" do
      expect {
        headshot.set_as_background_image
      }.to change {
        headshot_as_background.reload.is_background?
      }.from(true).to(false)
    end

    it "sets itself as background image" do
      expect {
        headshot.set_as_background_image
      }.to change {
        headshot.reload.is_background?
      }.from(false).to(true)
    end
  end

  describe "#remove_as_background_image" do
    it "removes itself as background image" do
      expect {
        headshot_as_background.remove_as_background_image
      }.to change {
        headshot_as_background.reload.is_background?
      }.from(true).to(false)
    end
  end
end