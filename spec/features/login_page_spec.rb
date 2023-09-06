require 'rails_helper'

RSpec.describe 'Logging In' do
  it 'can log in with valid credentials' do
    user = User.create(
      name: 'User One',
      email: 'user_one@turing.edu',
      password: 'password123',
      password_confirmation: 'password123'
    )

    visit login_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Log In'

    expect(current_path).to eq(user_path(user.id))
    expect(page).to have_content("Welcome, #{user.name}!")
  end

  it 'cannot log in with invalid credentials' do
    user = User.create(
      name: 'User One',
      email: 'user_one@turing.edu',
      password: 'password123',
      password_confirmation: 'password123'
    )

    visit login_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: 'password987'
    click_button 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Invalid email or password')
  end

  # Part 1, Task 1
  # As a logged in user
  # When I visit the landing page
  # I no longer see a link to Log In or Create an Account
  # But I see a link to Log Out.
  # When I click the link to Log Out
  # I'm taken to the landing page
  # And I can see that the Log Out link has changed back to a Log In link

  it 'does not show login button or create account button and does show a logout button when logged in' do
    user = User.create(
      name: 'User One',
      email: 'user_one@turing.edu',
      password: 'password123',
      password_confirmation: 'password123'
    )

    visit login_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Log In'
    click_link 'Home'
    expect(page).to_not have_content('Log In')
    expect(page).to_not have_content('Create Account')
    expect(page).to have_content('Logout')
  end

  it 'can log out to landing page and shows Log In and Create Account buttons' do
    user = User.create(
      name: 'User One',
      email: 'user_one@turing.edu',
      password: 'password123',
      password_confirmation: 'password123'
    )

    visit login_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Log In'
    click_link 'Home'
    click_button 'Logout'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Login')
    expect(page).to have_content('Create New User')
  end
end
