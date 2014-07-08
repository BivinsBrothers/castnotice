require "spec_helper"

describe CritiqueResponsesController do
	let(:user) { create(:user, :mentor) }

	before do
		log_in user
	end

	describe "#create" do
		it "sets success message and redirects to critique path after successful save" do
			critique = create(:critique)
			post :create, critique_id: critique.uuid, critique_response: attributes_for(:critique_response)

			expect(flash[:success]).to eq("Your response has been sent.")
			expect(response).to redirect_to(critiques_path)
		end

		it "sets failure message and redirects to critique path if the critique is closed" do
			critique = create(:critique, :closed)
			post :create, critique_id: critique.uuid, critique_response: attributes_for(:critique_response)			

			expect(response).to redirect_to(critiques_path)
		end

		it "sets failure message and renders the new form again if validation fails" do
			critique = create(:critique)
			post :create, critique_id: critique.uuid, critique_response: attributes_for(:critique_response, body: nil)			

			expect(flash[:failure]).to eq("Please try to send your response again.")
			expect(response).to redirect_to(critique_path(critique))
		end
	end
end