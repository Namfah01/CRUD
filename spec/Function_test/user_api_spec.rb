require 'rails_helper'

RSpec.describe "User authentication", type: :request do
  let(:user) { create(:user) }  # Assuming you're using FactoryBot
  let(:valid_attributes) { { email: "test@example.com", password: "password123" } }

  describe "GET /users/sign_in" do
    it "renders the sign in page" do
      get new_user_session_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /users/sign_in" do
    context "with valid credentials" do
      it "signs in the user" do
        post user_session_path, params: { user: { email: user.email, password: user.password } }
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("Signed in successfully")
      end
    end

    context "with invalid credentials" do
      it "does not sign in the user" do
        post user_session_path, params: { user: { email: user.email, password: "wrongpassword" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Invalid Email or password")
      end
    end
  end

  describe "DELETE /users/sign_out" do
    it "signs out the user" do
      sign_in user
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("Signed out successfully")
    end
  end

  describe "GET /users/sign_up" do
    it "renders the sign up page" do
      get new_user_registration_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /users" do
    context "with valid parameters" do
      it "creates a new user" do
        expect {
          post user_registration_path, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new user" do
        expect {
          post user_registration_path, params: { user: { email: "", password: "" } }
        }.to_not change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /users/edit" do
    it "renders the edit profile page" do
      sign_in user
      get edit_user_registration_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /users" do
    context "with valid parameters" do
      it "updates the user's profile" do
        sign_in user
        new_email = "newemail@example.com"
        put user_registration_path, params: { user: { email: new_email, current_password: user.password } }
        expect(response).to redirect_to(root_path)
        expect(user.reload.email).to eq(new_email)
      end
    end

    context "with invalid parameters" do
      it "does not update the user's profile" do
        sign_in user
        put user_registration_path, params: { user: { email: "", current_password: user.password } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

      describe "DELETE /users" do
    context "with valid parameters" do
      it "deletes the user profile and redirects to root path" do
        params = {
          email: user.email,
          current_password: user.password
        }

        delete user_registration_path, params: params
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(user_session_path)
      end
      end
    end
  end
end
