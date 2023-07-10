Rails.application.routes.draw do
  post '/login', to: 'authentication#login'
  resources :users, only: [:create, :show, :update]

  resources :theatres, only: [:create, :show ,:update ,:destroy]

  resources :screens, only: [:create, :show, :index, :update]

  resources :movies, only: [:create, :show ,:update]
  
  resources :tickets, only: [:create, :show,]


  get "/available_movie", to: 'movies#movie_time'

  get "/movie/search", to: 'movies#search_movie'
  # post "/movies/search", to: 'movies#search_movie'

  post "/book_ticket", to: 'tickets#ticket_generate'

  get "/perticular_user_all_tickets", to: 'tickets#index'

  get "/all_theatres", to: 'theatres#index'

  #put "/update_theatre", to: 'theatres#update'








end
