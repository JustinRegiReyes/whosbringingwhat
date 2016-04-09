Rails.application.routes.draw do

  get '/', to: "welcome#index"

  post '/sessions', to: 'sessions#create'

  resources :users

end
