require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let(:valid_attributes) do
    {
      user: {
        email: "test@example.com",
        password: "password",
        password_confirmation: "password"
      }
    }
  end

  let(:invalid_attributes) do
    {
      user: {
        email: "invalid_email",
        password: "password",
        password_confirmation: "mismatch"
      }
    }
  end

  describe "POST /users_sign_in" do
    context "with valid parameters" do
      it "creates a new user and returns a 201 status" do
        expect {
          post "/users_sign_in", params: valid_attributes
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)

        json_response = JSON.parse(response.body)
        expect(json_response['email']).to eq("test@example.com")
      end
    end

    context "with invalid parameters" do
      it "does not create a new user and returns a 422 status" do
        expect {
          post "/ussrs_sign_up", params: invalid_attributes
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to be_present
      end
    end
  end
end
