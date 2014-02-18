require "spec_helper"

describe RegistrationsController do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#create" do
    it "saves a user when given valid parameters" do
      user_params = { "user" => {
          "name" => "Test Dummy",
          "email" => "test@fake.com",
          "password" => "goodpassword",
          "password_confirmation" => "goodpassword",
          "location_address" => "123 Somewhere",
          "location_city" => "Grand Rapids",
          "location_state" => "MI",
          "location_zip" => "49506",
          "birthday" => "1987-9-17"
        }
      }

      post :create, user_params

      expect(response).to redirect_to(:dashboard)

      user = User.last

      expect(user.name).to eq("Test Dummy")
      expect(user.email).to eq("test@fake.com")

      expect(user.location_address).to eq("123 Somewhere")
      expect(user.location_city).to eq("Grand Rapids")
      expect(user.location_state).to eq("MI")
      expect(user.location_zip).to eq("49506")

      expect(user.birthday).to eq(Date.new(1987, 9, 17))
    end

    it "renders new when user could not be saved" do
      post :create, user: attributes_for(:user, name: "")

      expect(response).to render_template(:new)
    end
  end
end
