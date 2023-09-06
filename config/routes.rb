Rails.application.routes.draw do
  # Landing Page
  root 'welcome#index'

  # User Dashboard
  get '/dashboard', to: 'users#show', as: :dashboard

  # User Registration
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'

  # User Movies
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'

  # User Movie Parties
  get '/users/:user_id/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new'
  post '/users/:user_id/movies/:movie_id/viewing_parties', to: 'viewing_parties#create'

  # User Login
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'

  # User Logout
  delete '/logout', to: 'sessions#destroy', as: :logout

  resources :users, only: [:show] do
    resources :movies, only: %i[index show] do
      resources :viewing_parties, only: %i[new create]
    end
  end
end
