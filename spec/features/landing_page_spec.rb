require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do
    @user1 = User.create(name: 'User One', email: 'user1@test.com', password: 'password1',
                         password_confirmation: 'password1')
    @user2 = User.create(name: 'User Two', email: 'user2@test.com', password: 'password2',
                         password_confirmation: 'password2')
    visit '/'
  end

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do
    click_button 'Create New User'

    expect(current_path).to eq(register_path)

    visit '/'
    click_link 'Home'

    expect(current_path).to eq(root_path)
  end

  # Task 3: User Story 1
  # As a visitor
  # When I visit the landing page
  # I do not see the section of the page that lists existing users

  it 'does show existing users when logged in' do
    visit '/'
    click_button 'Login'
    fill_in :user_email, with: @user1.email
    fill_in :user_password, with: @user1.password
    click_button 'Log In'
    click_link 'Home'

    expect(page).to have_content(@user1.email)
    expect(page).to have_content(@user2.email)
  end

  it 'does not show existing users when not logged in' do
    visit '/'
    click_button 'Login'
    fill_in :user_email, with: @user1.email
    fill_in :user_password, with: @user1.password
    click_button 'Log In'
    click_link 'Home'
    click_button 'Logout'

    expect(page).to_not have_content(@user1.email)
    expect(page).to_not have_content(@user2.email)
  end

  # Task 4: User Story #2
  # As a registered user
  # When I visit the landing page
  # The list of existing users is no longer a link to their show pages
  # But just a list of email addresses
  it 'does not show existing users as links when logged in' do
    visit '/'
    click_button 'Login'
    fill_in :user_email, with: @user1.email
    fill_in :user_password, with: @user1.password
    click_button 'Log In'
    click_link 'Home'

    expect(page).to have_content(@user1.email)
    expect(page).to have_content(@user2.email)

    expect(page).to_not have_link(@user1.email)
    expect(page).to_not have_link(@user2.email)
  end

  # Task 5: User Story #3
  # As a visitor
  # When I visit the landing page
  # And then try to visit '/dashboard'
  # I remain on the landing page
  # And I see a message telling me that I must be logged in or registered to access my dashboard

  it 'does not allow visitors to visit /dashboard if they are not logged in' do
    visit '/'
    click_button 'Login'
    fill_in :user_email, with: @user1.email
    fill_in :user_password, with: @user1.password
    click_button 'Log In'
    click_link 'Home'
    click_button 'Logout'

    visit dashboard_path
    expect(page).to have_content('You must be logged in or registered to access your dashboard.')
  end
end
