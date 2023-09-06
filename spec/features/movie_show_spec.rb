require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  before do
    @user1 = User.create(name: 'User One', email: 'user1@test.com', password: 'password1',
                         password_confirmation: 'password1')
    i = 1
    20.times do
      Movie.create(title: "Movie #{i} Title", rating: rand(1..10),
                   description: "This is a description about Movie #{i}")
      i += 1
    end
  end

  it 'shows all movies' do
    visit login_path
    fill_in :user_email, with: @user1.email
    fill_in :user_password, with: @user1.password
    click_button 'Log In'
    visit "users/#{@user1.id}"

    click_button 'Find Top Rated Movies'

    expect(current_path).to eq("/users/#{@user1.id}/movies")

    expect(page).to have_content('Top Rated Movies')

    movie_1 = Movie.first

    click_link(movie_1.title)

    expect(current_path).to eq("/users/#{@user1.id}/movies/#{movie_1.id}")

    expect(page).to have_content(movie_1.title)
    expect(page).to have_content(movie_1.description)
    expect(page).to have_content(movie_1.rating)
  end

  # Task 6: User Story #4
  # As a visitor
  # If I go to a movies show page
  # And click the button to create a viewing party
  # I'm redirected to the movies show page, and a message appears to let me know I must be logged in or registered to create a movie party.

  it 'shows a message to log in or register to create a movie party' do
    movie = Movie.first
    visit "/users/#{@user1.id}/movies/#{movie.id}"
    click_button 'Create a Viewing Party'

    expect(page).to have_content('You must be logged in or registered to create a movie party.')
  end

  it 'does not show a message to log in or register to create a movie party if logged in' do
    movie = Movie.first
    visit login_path
    fill_in :user_email, with: @user1.email
    fill_in :user_password, with: @user1.password
    click_button 'Log In'
    visit "/users/#{@user1.id}/movies/#{movie.id}"
    click_button 'Create a Viewing Party'

    expect(page).to_not have_content('You must be logged in or registered to create a movie party.')
  end
end
