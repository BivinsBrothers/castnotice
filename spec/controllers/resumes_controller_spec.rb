require "spec_helper"

describe ResumesController do
  describe "#show" do
    let(:user) { create(:user) }

    before do
      log_in user
    end

    it "allows a user to preview resume that has a resume" do
      create(:resume, user: user)

      get :show

      expect(response).to render_template("show")
    end
  end
end
