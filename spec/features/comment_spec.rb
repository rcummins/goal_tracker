require 'spec_helper'
require 'rails_helper'

feature 'comments' do
    subject(:user) { FactoryBot.create(:user) }

    before(:each) do
        visit new_user_url
        fill_in 'Username', with: 'renata'
        fill_in 'Password', with: 'password123'
        click_on 'Sign up'
    end

    feature 'creating a new comment on a user' do
        scenario 'the comment displays on the user show page' do
            click_on 'Add a comment'
            fill_in 'Enter your comment:', with: 'Keep up the good work!'
            click_on 'Submit comment'
            expect(page).to have_content('Keep up the good work!')
            expect(page).to have_content('-renata')
        end

        scenario 'an empty comment gives an error' do
            click_on "Add a comment"
            click_on 'Submit comment'
            expect(current_path).to eq("/users/#{user.id}/user_comments/new")
            expect(page).to have_content("Comment text can't be blank")
        end
    end
end
