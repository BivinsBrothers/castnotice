require "spec_helper"

describe ResumesController do
  describe "#show" do
    let(:user) { create(:user) }

    before do
      log_in user
    end

    it "allow user to preview resume that has a resume" do
      create(:resume, user: user)

      get :show

      expect(response).to render_template("show")
    end

    it "redirect user to new resume when they do not have one" do
      get :show

      expect(response).to redirect_to(edit_resume_path)

      expect(flash[:notice]).to eq("Fill in the information you wish to appear on your resume.")
    end
  end
end