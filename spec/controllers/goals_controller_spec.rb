require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
    subject(:user) { FactoryBot.create(:user) }
    subject(:goal) { FactoryBot.build(:goal) }

    describe 'GET #show' do
        it 'renders the goal show template' do
            goal.save!
            get :show, params: { id: goal.id }
            expect(response).to have_http_status(:success)
            expect(response).to render_template(:show)
        end
    end

    describe 'GET #new' do
        it 'returns http success' do
            get :new, params: { user_id: user.id }
            expect(response).to have_http_status(:success)
        end
    end

    describe 'POST #create' do
        context 'with valid params' do
            it 'redirects to goal show page' do
                post :create, params: { goal: {
                    user_id: user.id,
                    title: goal.title,
                    description: goal.description,
                    due_date: goal.due_date,
                    privacy: goal.privacy
                }}
                expect(response).to redirect_to(goal_url(assigns(:goal)))
            end
        end

        context 'with invalid params' do
            it 'validates the presence of user_id' do
                post :create, params: { goal: {
                    title: goal.title,
                    privacy: goal.privacy
                }}
                expect(response).to render_template(:new)
                expect(flash[:errors]).to include("User must exist")
            end

            it 'validates the presence of title' do
                post :create, params: { goal: {
                    user_id: user.id,
                    privacy: goal.privacy
                }}
                expect(response).to render_template(:new)
                expect(flash[:errors]).to include("Title can't be blank")
            end

            it 'validates the presence of privacy' do
                post :create, params: { goal: {
                    user_id: user.id,
                    title: goal.title
                }}
                expect(response).to render_template(:new)
                expect(flash[:errors]).to include("Privacy can't be blank")
            end

            it 'validates that privacy is either Public or Private' do
                post :create, params: { goal: {
                    user_id: user.id,
                    title: goal.title,
                    privacy: 'Bad privacy status'
                }}
                expect(response).to render_template(:new)
                expected_error_msg = "Privacy is not included in the list"
                expect(flash[:errors]).to include(expected_error_msg)
            end
        end
    end
end
