require 'spec_helper'
require 'rails_helper'

feature 'goals' do
    subject(:user) { FactoryBot.create(:user) }

    before(:each) do
        visit new_user_url
        fill_in 'Username', with: 'renata'
        fill_in 'Password', with: 'password123'
        click_on 'Sign up'
    end

    feature 'creating a new goal' do

        scenario 'has a new goal page' do
            click_on "Add a new goal"
            expect(page).to have_content("Create a new goal")
        end

        scenario 'new goal page not available to logged out user' do
            click_on 'Log out'
            visit new_user_goal_url(user)
            expect(current_path).to eq("/users")
        end

        scenario 'lists the goal on the goal show page after creation' do
            click_on "Add a new goal"
            fill_in "Title", with: "Hike all New Hampshire 4,000 footers"
            choose("Public")
            click_on "Create goal"
            expect(page).to have_content("Hike all New Hampshire 4,000 footers")
            expect(page).to have_content("This goal is public.")
            expect(page).to have_content("This goal has not been completed.")
        end
    end

    feature 'editing a goal' do
        before(:each) do
            click_on 'Add a new goal'
            fill_in 'Title', with: 'Eat fewer cupcakes'
            choose('Public')
            click_on 'Create goal'
        end

        scenario 'has an edit goal page with goal attributes populated' do
            click_on 'Edit goal'
            expect(page).to have_content('Edit your goal')
            expect(find_field('Title').value).to eq('Eat fewer cupcakes')
            expect(find_field('Public')).to be_checked
        end

        scenario 'lists the updated goal on the goal show page after update' do
            click_on 'Edit goal'
            fill_in 'Description', with: 'Go one month without eating any cupcakes'
            choose('Private')
            click_on 'Update goal'
            expect(page).to have_content('Eat fewer cupcakes')
            expect(page).to have_content('Go one month without eating any cupcakes')
            expect(page).to have_content('This goal is private')
        end
    end

    feature 'deleting a goal' do
        before(:each) do
            click_on 'Add a new goal'
            fill_in 'Title', with: 'Eat fewer cupcakes'
            choose('Public')
            click_on 'Create goal'
        end

        scenario 'goal disappears from user show page after delete' do
            click_on "See all of renata's goals"
            expect(page).to have_content('Goal title')
            expect(page).to have_content('Eat fewer cupcakes')
            click_on 'Eat fewer cupcakes'
            click_on 'Delete goal'
            expect(page).not_to have_content('Eat fewer cupcakes')
        end
    end

    feature 'private goals are visible only to owner' do
        before(:each) do
            click_on 'Add a new goal'
            fill_in 'Title', with: 'Give better birthday presents'
            choose('Private')
            click_on 'Create goal'
        end

        scenario 'private goals are hidden from logged out users' do
            click_on 'Log out'
            click_on 'Goal Tracker'
            click_on 'renata'
            expect(page).to have_content('Currently logged out')
            expect(page).to have_content("renata's goals")
            expect(page).not_to have_content('Give better birthday presents')
        end

        scenario 'private goals are hidden from other users' do
            click_on 'Log out'
            click_on 'Sign up'
            fill_in 'Username', with: 'jen'
            fill_in 'Password', with: 'password'
            click_on 'Sign up'
            click_on 'Goal Tracker'
            click_on 'renata'
            expect(page).to have_content('Logged in as jen')
            expect(page).to have_content("renata's goals")
            expect(page).not_to have_content('Give better birthday presents')
        end
    end

    feature 'completing a goal' do
        before(:each) do
            click_on 'Add a new goal'
            fill_in 'Title', with: 'Eat fewer cupcakes'
            choose('Public')
            click_on 'Create goal'
        end

        scenario 'mark as completed button changes goal to completed' do
            expect(page).not_to have_content('This goal has been completed!')
            click_on 'Mark goal as completed'
            expect(page).to have_content('This goal has been completed!')
        end
    end
end