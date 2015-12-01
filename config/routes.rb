Rails.application.routes.draw do
  get 'users/new'

  get 'users/show'

  get 'users/edit'

  get 'users/index'

  get 'users/delete'

  get '/', to: "welcome#index"
end
