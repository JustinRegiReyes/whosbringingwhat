Rails.application.routes.draw do

  get '/', to: "welcome#index"

  get '/login', to: "sessions#new"

  get '/signup', to: "users#new"

  post '/users', to: "users#create"

  get '/home', to: "users#show"

  get 'sessions/destroy'

  get 'users/new'

  get 'users/show'

  get 'users/edit'

  get 'users/index'

  get 'users/delete'

  
end
