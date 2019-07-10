require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
    scenario 'has a new user page' do
        visit new_user_url
        expect(page).to have_content("Sign up")
        expect(page).to have_content("Username")
        expect(page).to have_content("Password")
    end

    scenario 'clicking the Sign up button takes you to the sign up page' do
        visit users_url
        click_on "Sign up"
        expect(current_path).to eq("/users/new")
    end

    feature 'signing up a user' do
        scenario 'shows username on the homepage after signup' do
            visit new_user_url
            fill_in "Username", with: "renata"
            fill_in "Password", with: "password"
            click_on "Sign up"
            expect(page).to have_content("Logged in as renata")
        end
    end
end

feature 'logging in' do
    scenario 'clicking the Log in button takes you to the log in page' do
        visit users_url
        click_on "Log in"
        expect(current_path).to eq("/session/new")
    end
    
    scenario 'shows username on the homepage after logging in' do
        FactoryBot.create(:user, username: 'renata', password: 'password')
        visit new_session_url
        fill_in "Username", with: "renata"
        fill_in "Password", with: "password"
        click_on "Log in"
        expect(page).to have_content("Logged in as renata")
    end
end

feature 'logging out' do
    scenario 'begins with a logged out state' do
        visit users_url
        expect(page).to have_content("Currently logged out")
    end

    scenario 'does not show username on the homepage after logout' do
        FactoryBot.create(:user, username: 'renata', password: 'password')
        visit new_session_url
        fill_in "Username", with: "renata"
        fill_in "Password", with: "password"
        click_on "Log in"
        expect(page).to have_content("Logged in as renata")
        click_on "Log out"
        expect(page).to have_content("Currently logged out")
    end
end
