Rails.application.routes.draw do

  get 'calendar/index'

  get '/', to: "welcome#index"

  get '/calendar', to: 'calendar#index'

  # users routes
    resources :users, except: [:create]
    post "/signup", to: 'users#create'
    get '/home', to: 'users#home'

  # events routes
  	resources :events

  # sessions routes
	post '/sessions', to: 'sessions#create'
	delete '/sessions', to: 'sessions#destroy'

end
