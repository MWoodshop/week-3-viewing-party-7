Rails.application.routes.draw do
  root 'welcome#index'

  # User Registration
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'

  # User Movies
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'

  # User Login
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'

  # User Logout
  delete '/logout', to: 'sessions#destroy', as: :logout

  resources :users, only: :show
end
