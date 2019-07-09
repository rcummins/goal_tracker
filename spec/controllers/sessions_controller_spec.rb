require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it 'redirects to user show page' do
        user = FactoryBot.create(:user, password: 'password')
        post :create, params: { user: {
          username: user.username, password: 'password' } }
        expect(response).to redirect_to user_url(user.id)
      end
    end

    context "with invalid params" do
      it "gives error message and renders new template" do
        user = FactoryBot.create(:user, password: 'password')
        post :create, params: { user: {
          username: user.username, password: 'bad_password' } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to include("Incorrect username and/or password")
      end
    end
  end

  describe "DELETE #destroy" do
    it "redirects to sign-in page" do
      delete :destroy
      expect(response).to redirect_to(new_session_url)
    end
  end

end
