require "spec_helper"

describe ResumeForm do
  let(:user) { double(:user, resume: nil) }
  let(:resume_form) { ResumeForm.new(user) }

  describe "#height" do
    it "returns height as total inches" do
      resume_form.height_feet = 3
      resume_form.height_inches = 5

      expect(resume_form.height).to eq(41)
    end
  end

  describe "#height=" do
    it "sets @height_feet and @height_inches correctly" do
      resume_form.height = 25

      expect(resume_form.height_feet).to eq(2)
      expect(resume_form.height_inches).to eq(1)
    end
  end
end