Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'users/new'

  get 'users/show'

  get 'users/edit'

  get 'users/index'

  get 'users/delete'

  get '/', to: "welcome#index"
end
