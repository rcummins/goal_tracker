require 'spec_helper'
require 'rails_helper'

feature 'comments' do
    before(:each) do
        visit new_user_url
        fill_in 'Username', with: 'renata'
        fill_in 'Password', with: 'password123'
        click_on 'Sign up'
    end

    feature 'creating a new comment on a user' do
        scenario 'the comment displays on the user show page' do
            fill_in 'Add a new comment:', with: 'Keep up the good work!'
            click_on 'Submit comment'
            expect(page).to have_content('Keep up the good work!')
            expect(page).to have_content('-renata')
        end

        scenario 'an empty comment gives an error' do
            click_on 'Submit comment'
            expect(page).to have_content("Add a new comment:")
            expect(page).to have_content("Comment text can't be blank")
        end
    end

    feature 'creating a new comment on a goal' do
        before(:each) do
            click_on "Add a new goal"
            fill_in "Title", with: "Hike all New Hampshire 4,000 footers"
            choose("Public")
            click_on "Create goal"
        end

        scenario 'the comment displays on the goal show page' do
            fill_in 'Add a new comment:', with: 'Sounds like a great goal!'
            click_on 'Submit comment'
            expect(page).to have_content("Sounds like a great goal!")
            expect(page).to have_content("-renata")
        end

        scenario 'an empty comment gives an error' do
            click_on 'Submit comment'
            expect(page).to have_content("Add a new comment:")
            expect(page).to have_content("Comment text can't be blank")
        end
    end
end
