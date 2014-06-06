require "spec_helper"

describe RegistrationsController do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#create" do
    it "renders new when user could not be saved" do
      post :create, user: attributes_for(:user, name: "")

      expect(response).to render_template(:new)
    end
  end
end
