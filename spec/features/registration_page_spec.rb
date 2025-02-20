require 'rails_helper'

RSpec.describe 'User Registration' do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with: 'user1@example.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end

  it 'does not create a user if email isnt unique' do
    User.create(name: 'User One', email: 'notunique@example.com', password: 'password123',
                password_confirmation: 'password123')

    visit register_path

    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with: 'notunique@example.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content('Email has already been taken')
  end

  it 'does not create a user if password and password confirmation do not match' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with: 'user1@turing.edu'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password987'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it 'does not create a user if name is blank' do
    visit register_path
    fill_in :user_name, with: ''
    fill_in :user_email, with: 'user1@turing.edu'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Name can't be blank")
  end

  it 'does not create a user if email is blank' do
    visit register_path
    fill_in :user_name, with: 'User One'
    fill_in :user_email, with: ''
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email can't be blank")
  end

  it 'does not create a user if password is blank' do
    visit register_path
    fill_in :user_name, with: 'User One'
    fill_in :user_email, with: 'user1@turing.edu'
    fill_in :user_password, with: ''
    fill_in :user_password_confirmation, with: ''
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password can't be blank")
  end

  it 'does not create a user if email and password are blank' do
    visit register_path
    fill_in :user_name, with: 'User One'
    fill_in :user_email, with: ''
    fill_in :user_password, with: ''
    fill_in :user_password_confirmation, with: ''
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end
