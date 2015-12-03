Rails.application.routes.draw do

  get '/', to: "welcome#index"

  get '/login', to: "sessions#new"

  get '/signup', to: "users#new"

  post '/users', to: "users#create"

  get '/home', to: "users#show"

  post '/sessions', to: "sessions#create"

  delete '/sessions', to: "sessions#destroy"
  
  get 'events/new', to: "events#new"

  get 'events/created', to: "events#created"

  get 'events/attending', to: "events#attending"

  post 'events/create', to: "events#create"

  get 'events/:id', to: "events#show"

  get 'events/edit', to: "events#edit"

  get 'events/index', to: "events#index"

  delete 'events/delete', to: "events#delete"

  get '/events/:id/categories/new', to: "categories#new"

  post '/categories/:event_id/create', to: "categories#create"

  get 'categories/show'

  get 'categories/edit'

  get 'categories/index'

  get 'categories/delete'

  get 'users/show'

  get 'users/edit'

  get 'users/index'

  get 'users/delete'

  
end
