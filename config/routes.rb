Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  get "/registration", to: 'users#new'
  post "/users", to: 'users#create'
  get "/dashboard", to: 'users#show'
  post '/dashboard', to: 'friendships#create'

  #login
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  resources :discover, only: :index

  get '/movies', to: 'movies#index'
end
