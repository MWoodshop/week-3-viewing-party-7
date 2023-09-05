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
end
