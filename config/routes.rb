Rails.application.routes.draw do

  get 'calendar/index'

  get '/', to: "welcome#index"

  post '/sessions', to: 'sessions#create'

  get '/calendar', to: 'calendar#index'

  # users routes
    resources :users, path: "signup", as: :users, only: [:create]
    get '/home', to: 'users#home'

end
