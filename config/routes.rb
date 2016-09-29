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
    post '/events/:id/guests/invite', to: 'events#send_invites'
    get '/events/:id/guests/:type', to: 'events#guests'
    get '/my_events', to: 'events#my_events'

  # attending_event routes
    get '/invitations', to: 'attending_events#my_invitations'
    patch '/attending_events/:id/accept', to: 'attending_events#accept'
    patch '/attending_events/:id/decline', to: 'attending_events#decline'
    patch '/attending_events/:id/maybe', to: 'attending_events#maybe'

  # categories routes
    get '/events/:event_id/categories/edit', to: 'categories#in_event_edit'
    patch '/events/:event_id/categories/:category_id', to: 'categories#update'
    get '/events/:event_id/categories/:category_id/edit', to: 'categories#edit'
    get '/events/:event_id/categories/:category_id', to: 'categories#show'

  # items routes
    get '/events/:event_id/categories/:category_id/items/new', to: 'items#new'
    get '/events/:event_id/categories/:category_id/items/:item_id', to: 'items#event_show'

  #friendship routes
    get '/friend_requests', to: 'friendships#my_friend_requests'
    get '/friends/invite/events/:event_id', to: 'friendships#invite_friends'
    post '/friendships/:friend_id/friend_request', to: 'friendships#friend_request'
    patch '/friendships/:friendship_id/friend_accept', to: 'friendships#friend_accept'
    patch '/friendships/:friendship_id/friend_decline', to: 'friendships#friend_decline'

  #notification routes
    get '/notifications', to: 'notifications#my_notifications'
    patch '/notifications/dismiss', to: 'notifications#dismiss'
    patch '/notifications/dismiss_all', to: 'notifications#dismiss_all'
  # sessions routes
	post '/sessions', to: 'sessions#create'
	delete '/sessions', to: 'sessions#destroy'

end
