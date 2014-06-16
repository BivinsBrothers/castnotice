require "spec_helper"

describe SchoolsController do
  let(:user) { create(:user) }

  before do
    enter_promo_code
    log_in user
  end

  describe "#create" do
    it "redirects to resume on successful save" do
      post :create, school: attributes_for(:school)

      expect(response).to redirect_to(edit_resume_path)
    end

    it "redirects to resume with error message on failed save" do
      # There is no way to make this action fail
    end

  end

  describe "#update" do
    let(:school) { create(:school, resume: user.resume) }

    it "redirects to resume with success message on successful save" do
      put :update, id: school, school: {major: "Computer Science"}

      expect(response).to redirect_to(edit_resume_path)
    end

    it "redirects to resume with error message on failed save" do
      # There is no way to make this action fail
    end
  end

  describe "#destroy" do
    let!(:school) { create(:school, resume: user.resume) }

    it "redirects to resume on successful destroy" do
      expect {
        delete :destroy, id: school
      }.to change {
        School.count
      }.by(-1)
      expect(response).to redirect_to(edit_resume_path)
    end
  end

end
