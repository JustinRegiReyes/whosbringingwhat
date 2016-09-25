class UsersController < ApplicationController
  before_action :logged_in?, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.create(newuser_params)
    createdUser = User.find_by_id(@user.id)
    if createdUser
      login(@user)
      redirect_to "/home"
    else
      # flash[:notice] = "An account with that username and password has not been found."
      # redirect_to "/"
      render "/welcome/index"
    end

  end

  def show
  end

  def home
  end

  def edit
  end

  def index
  end

  def delete
  end

  def search
    @users = User.all
    binding.pry
  end

  private

  def newuser_params
    params.require(:user).permit(:username, :password, :avi)
  end
end
