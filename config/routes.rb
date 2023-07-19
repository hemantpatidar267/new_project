Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post '/login', to: 'authentication#login'

  resource :users

  resources :theatres, only: [:create, :show, :update, :index]

  resources :screens, only: [:create, :show, :index, :update, :destroy]

  resources :movies, only: [:create, :show, :index, :update]
  
  resources :tickets, only: [:create, :show, :index]


  get "/available_movie", to: 'movies#movie_time'

  get '/search_theatre_by_movie', to: 'theatres#search_theatre_by_movie'

end
