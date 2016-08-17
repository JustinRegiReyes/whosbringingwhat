Rails.application.routes.draw do

  get '/', to: "welcome#index"

  get '/calendar', to: 'calendar#index'

  get '/calendar/events', to: 'calendar#events'


  # users routes
    resources :users, except: [:create]
    post "/signup", to: 'users#create'
    get '/home', to: 'users#home'

  # events routes
    resources :events
    post '/events/:id/comments', to: 'comments#create'
    get '/events/:id/guests/:type', to: 'events#guests'


  # sessions routes
	post '/sessions', to: 'sessions#create'
	delete '/sessions', to: 'sessions#destroy'

end
