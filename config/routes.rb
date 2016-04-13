Rails.application.routes.draw do

  get '/', to: "welcome#index"

  post '/sessions', to: 'sessions#create'

  # users routes
    resources :users, path: "signup", as: :users, only: [:create]
    get '/home', to: 'users#home'

end
