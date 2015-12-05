Rails.application.routes.draw do

  get '/', to: "welcome#index"

  get 'login', to: "sessions#new"

  get 'signup', to: "users#new"

  post '/users', to: "users#create"

  get '/home', to: "users#show"

  post '/sessions', to: "sessions#create"

  delete '/sessions', to: "sessions#destroy"
  
  get 'events/new', to: "events#new"

  get 'events/created', to: "events#created"

  get 'events/:id/attending', to: "events#attending"

  get 'events/my-events', to: "events#attendingIndex"

  post 'events/create', to: "events#create"

  post 'events/search', to: "events#find"

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

  get 'items/:event_id/new', to: "items#new"

  post 'items/:event_id/create', to: "items#create"

  get 'items/show'

  get 'items/edit'

  get 'items/bringingIndex', to: "items#bringingIndex"

  get 'items/delete'

  
end
