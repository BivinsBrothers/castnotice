require "spec_helper"

describe ResumesController do
  describe "#show" do
    it "allow user to preview resume that has a resume" do
      user = create(:user)
      create(:resume, user: user)
      log_in user

      get :show

      expect(response).to render_template("show")
    end

    it "redirect user to new resume when they do not have one" do
      user = create(:user)
      log_in user

      get :show

      expect(response).to redirect_to(new_resume_path)

      expect(flash[:notice]).to eq("Fill in the information you wish to appear on your resume.")
    end
  end
end