require 'rails_helper'

RSpec.feature "The sign up process", type: :feature do
  scenario "Signing up with incorrect credentials" do
    visit 'users/sign_up'

    within "#new_user" do
      fill_in 'Email', with: 'wrongemail'
      fill_in 'Password', with: 'passW0rd'
      fill_in 'Password confirmation', with: 'passW0rd'
    end

    click_button '註冊'
    expect(page).to have_content '請'
  end

  scenario "Signing up with correct credentials" do
    visit 'users/sign_up'

    within "#new_user" do
      fill_in 'Email', with: 'hello@example.com'
      fill_in 'Password', with: 'passW0rd'
      fill_in 'Password confirmation', with: 'passW0rd'
    end

    click_button '註冊'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
