require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  subject(:user) { FactoryBot.create(:user, password: 'password') }

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
          username: user.username, password: 'password' } }
      end

      it 'logs in the user' do
        updated_user = User.find(user.id)
        expect(session[:session_token]).to eq(updated_user.session_token)
      end

      it 'redirects to user show page' do
        expect(response).to redirect_to user_url(user.id)
      end
    end

    context "with invalid params" do
      before(:each) do
        post :create, params: { user: {
          username: user.username, password: 'bad_password' } }
      end

      it 'does not log in the user' do
        expect(session[:session_token]).to be nil
      end

      it "gives error message and renders new template" do
        expect(response).to render_template(:new)
        expect(flash[:errors]).to include("Incorrect username and/or password")
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      post :create, params: { user: { 
        username: user.username, password: user.password } }
      delete :destroy
    end

    it 'logs out the user' do
      expect(session[:session_token]).to be nil
    end

    it "redirects to sign-in page" do
      expect(response).to redirect_to(new_session_url)
    end
  end

end
