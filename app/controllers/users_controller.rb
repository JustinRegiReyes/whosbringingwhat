class UsersController < ApplicationController
  before_action :logged_in?, only: [:show]
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:username, :password)
    @user = User.create(user_params)
    createdUser = User.find_by_id(@user.id)

    if createdUser
      login(@user)
      redirect_to "/home"
    else
      redirect_to "/signup"
    end

  end

  def show
    
    render "home.html.erb"
 
  end

  def edit
  end

  def index
  end

  def delete
  end
end
