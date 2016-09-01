Rails.application.routes.draw do

  get '/', to: "welcome#index"

  get '/calendar', to: 'calendar#index'

  get '/calendar/events', to: 'calendar#events'


  # users routes
    resources :users, except: [:create]
    post "/signup", to: 'users#create'
    get '/home', to: 'users#home'

  # events routes
    get '/events/search', to: 'events#search'
    resources :events
    post '/events/:id/comments', to: 'comments#create'
    get '/events/:id/guests/:type', to: 'events#guests'

  # categories routes
    get '/events/:event_id/categories/:category_id', to: 'categories#show'
    get '/events/:event_id/categories/:category_id/items/:item_id', to: 'items#event_show'


  # sessions routes
	post '/sessions', to: 'sessions#create'
	delete '/sessions', to: 'sessions#destroy'

end
