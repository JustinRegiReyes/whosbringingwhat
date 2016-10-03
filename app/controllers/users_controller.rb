class UsersController < ApplicationController
  before_action :logged_in?, only: [:show, :home]
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
    @user = User.find_by_id(current_user.id)
  end

  def index
  end

  def delete
  end

  def search
    if user_search_params
      @users = User.by_username(user_search_params[:username]).by_email(user_search_params[:email])
      @user_search_params = user_search_params
    end
  end

  def update
    user = User.find_by_id(current_user.id)
    if user_password_change
      pass_changed = user.update_password(new_pass, retype_pass)
    end
    if user.errors.count < 1 && user.update(user_params)
      flash[:success] = "Edits saved"
      redirect_to "/my_profile/edit"
    else
      @user = user
      render "/users/edit"
    end
  end

  def avi_crop
    userId = current_user.id
    @user = User.find_by_id(userId)
  end

  def update_avi_crop
    userId = current_user.id
    user = User.find_by_id(userId)
    user.update(avi_crop_params)
    flash[:success] = "Avi cropped"
    redirect_to "/my_profile/edit"
  end

  private

  def newuser_params
    params.require(:user).permit(:username, :password, :avi, :email)
  end

  def user_search_params
    if params.has_key?(:user)
      params.require(:user)
    end
  end

  def user_id
    
  end

  def user_params
    params.require(:user).permit(:username, :avi, :email, :bio, :from, :crop_x, :crop_y, :crop_h, :crop_w)
  end

  def user_password_change
    params[:user][:new_pass].empty? == false || params[:user][:retype_pass].empty? == false
  end

  def new_pass
    params[:user][:new_pass]
  end

  def retype_pass
    params[:user][:retype_pass]
  end

  def avi_crop_params
    params.require(:user).permit(:avi_crop_x, :avi_crop_y, :avi_crop_w, :avi_crop_h)
  end

end
