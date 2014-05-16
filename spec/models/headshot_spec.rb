require "spec_helper"

describe Headshot do
  let(:resume) { create(:resume) }
  let!(:headshot) { create(:headshot, resume: resume) }
  let!(:headshot_as_background) { create(:headshot, resume: resume, background: true) }

  it "a resume can have only one background image" do
    headshot.background = true

    expect(headshot.save).to be_false
    expect(headshot).to have(1).errors_on(:background)
    expect(headshot.reload.background).to be_false
  end

  describe "#set_as_background_image" do
    it "removes current background image if set" do
      expect {
        headshot.set_as_background_image
      }.to change {
        headshot_as_background.reload.background?
      }.from(true).to(false)
    end

    it "sets itself as background image" do
      expect {
        headshot.set_as_background_image
      }.to change {
        headshot.reload.background?
      }.from(false).to(true)
    end
  end

  describe "#remove_as_background_image" do
    it "removes itself as background image" do
      expect {
        headshot_as_background.remove_as_background_image
      }.to change {
        headshot_as_background.reload.background?
      }.from(true).to(false)
    end
  end
end
