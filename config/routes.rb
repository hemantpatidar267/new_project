Rails.application.routes.draw do
  post '/login', to: 'authentication#login'
  resources :users, only: [:create, :show, :update, :index]

  resources :theatres, only: [:create, :show, :update, :index]

  resources :screens, only: [:create, :show, :index, :update, :destroy]

  resources :movies, only: [:create, :show, :index, :update]
  
  resources :tickets, only: [:create, :show, :index]


  get "/available_movie", to: 'movies#movie_time'

  get '/search_theatre_by_movie', to: 'movies#search_theatre_by_movie'

end
