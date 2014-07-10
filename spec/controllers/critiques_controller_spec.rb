require "spec_helper"

describe CritiquesController do
  let(:user) { create(:user, 
    stripe_customer_id: "cus_47oUnsvWTQWwPs",
    stripe_plan_id: "sub_4CFLiZFRyp52ya"
  ) }

  before do
    log_in user
  end

  vcr_options = { cassette_name: "create_valid_stripe_critique_payment" }
  describe "#create", vcr: vcr_options do
    it "sets a success message and redirects to dashboard path on success" do
      post :create, critique: attributes_for(:critique)

      expect(flash[:success]).to eq("Your critique request has been sent.")
      expect(response).to redirect_to(dashboard_path)
    end

    it "sets a failure message and renders the new template on failure" do
      post :create, critique: attributes_for(:critique, project_title: nil)

      expect(flash[:failure]).to eq("Your critique failed to send, please try again.")
      expect(response).to render_template(:new)
    end

    it "redirects if the current user cannot create a critique request" do
      log_in create(:user, :mentor)
      post :create, critique: attributes_for(:critique)

      expect(flash[:success]).to be_nil
      expect(flash[:failure]).to be_nil
      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe "#show" do
    it "renders the critique view" do
      critique = create(:critique, user: user)
      get :show, id: critique.uuid

      expect(response).to be_success
    end

    it "sets a failure message and redirects to the root path if I don't have permission to view" do
      critique = create(:critique, user: user)
      peer = create(:user)
      log_in peer

      get :show, id: critique.uuid

      expect(response).to redirect_to(root_path)
    end

  end

  describe "#index" do
    it "renders the index view" do
      mentor = create(:user, :mentor)
      log_in mentor
      get :index

      expect(response).to be_success
    end

    it "redirects to the dashboard if I don't have permission to view resumes" do
      get :index

      expect(response).to redirect_to(dashboard_path)
    end
  end
end
