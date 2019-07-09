require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    context "when the user exists" do
      it "renders the user show template" do
        user = FactoryBot.create(:user)
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
      end
    end

    context "when the user does not exist" do
      it "redirects to the users index page" do
        begin
          get :show, params: { id: -1 }
        rescue
          ActiveRecord::RecordNotFound
        end

        expect(response).to redirect_to(users_url)
      end
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "redirects to user show page" do
        post :create, params: { user: { username: 'renata', password: 'password' } }
        expect(response).to redirect_to(user_url(assigns(:user)))
      end
    end

    context "with invalid params" do
      it "validates the presence of username" do
        post :create, params: { user: { username: '', password: 'password' } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to include("Username can't be blank")
      end

      it "validates that the password is at least 8 characters" do
        post :create, params: { user: { username: 'renata', password: '1234567' } }
        expect(response).to render_template(:new)
        expected_error_msg = "Password is too short (minimum is 8 characters)"
        expect(flash[:errors]).to include(expected_error_msg)
      end
    end
  end

end
