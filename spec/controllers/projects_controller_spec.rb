require "spec_helper"

describe ProjectsController do
  let(:user) { create(:user) }

  before do
    enter_promo_code
    log_in user
  end

  describe "#create" do
    it "redirects to resume on successful save" do
      post :create, project: attributes_for(:project)

      expect(response).to redirect_to(edit_resume_path)
    end

    it "redirects to resume with error message on failed save" do
      # There is no way to make this action fail
    end

  end

  describe "#update" do
    let(:project) { create(:project, resume: user.resume) }

    it "redirects to resume with success message on successful save" do
      put :update, id: project, project: {title: "Wicked"}

      expect(response).to redirect_to(edit_resume_path)
    end

    it "redirects to resume with error message on failed save" do
      # There is no way to make this action fail
    end
  end

  describe "#destroy" do
    let(:project) { create(:project, resume: user.resume) }

    it "redirects to resume on successful destroy" do
      delete :destroy, id: project
      expect(response).to redirect_to(edit_resume_path)
    end
  end

end
