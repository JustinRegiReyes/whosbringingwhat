Rails.application.routes.draw do

  get '/', to: "welcome#index"

  get '/calendar', to: 'calendar#index'

  get '/calendar/events', to: 'calendar#events'


  # users routes
    get '/users/search', to: 'users#search'
    resources :users, except: [:create]
    post "/signup", to: 'users#create'
    get '/home', to: 'users#home'

  # events routes
    get '/events/search', to: 'events#search'
    resources :events
    post '/events/:id/comments', to: 'comments#create'
    get '/events/:id/guests/:type', to: 'events#guests'
    get '/myevents', to: 'events#my_events'

  # categories routes
    get '/events/:event_id/categories/:category_id', to: 'categories#show'

  # items routes
    get '/events/:event_id/categories/:category_id/items/new', to: 'items#new'
    get '/events/:event_id/categories/:category_id/items/:item_id', to: 'items#event_show'

  #friendship routes
    post '/friendships/:friend_id/friend_request', to: 'friendships#friend_request'
    patch '/friendships/:friend_id/friend_accept', to: 'friendships#friend_accept'

  #notification routes
    get '/notifications', to: 'notifications#my_notifications'
  # sessions routes
	post '/sessions', to: 'sessions#create'
	delete '/sessions', to: 'sessions#destroy'

end
