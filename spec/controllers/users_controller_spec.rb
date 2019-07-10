require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:user) { FactoryBot.build(:user) }

  describe "GET #index" do
    it "returns http success" do
      post :create, params: { user: {
          username: user.username, password: user.password } }
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "renders the user show template" do
      post :create, params: { user: {
          username: user.username, password: user.password } }
      created_user = User.find_by(username: user.username)
      get :show, params: { id: created_user.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
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
      before(:each) do
        post :create, params: { user: {
          username: user.username, password: user.password } }
      end

      it 'logs in user' do
        updated_user = User.find_by(username: user.username)
        expect(session[:session_token]).to eq(updated_user.session_token)
      end

      it "redirects to user show page" do
        expect(response).to redirect_to(user_url(assigns(:user)))
      end
    end

    context "with invalid params" do
      it 'does not log in user' do
        post :create, params: { user: { username: '', password: '' } }
        expect(session[:session_token]).to be nil
      end

      it "validates the presence of username" do
        post :create, params: { user: { username: '', password: 'password' } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to include("Username can't be blank")
      end

      it "validates that the password is at least 8 characters" do
        post :create, params: { user: { username: 'bob', password: '1234567' } }
        expect(response).to render_template(:new)
        expected_error_msg = "Password is too short (minimum is 8 characters)"
        expect(flash[:errors]).to include(expected_error_msg)
      end
    end
  end

end
