class UsersController < ApplicationController
  before_action :logged_in?, only: [:show, :home, :edit, :destroy]
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
      render "/welcome/index"
    end

  end

  def show
  end

  def home
    @user = User.find_by_id(current_user.id)
  end

  def edit
    @user = User.find_by_id(current_user.id)
  end

  def index
  end

  def destroy
    user = User.find_by_id(user_id)
    email = params[:email]
    if user.email == email
      respond_to do |format|
        user.destroy
        logout
        flash[:success] = "Deleted Profile"
        format.html { render layout: false }
        format.json { render :json => {data: "success" }, status: 200 }
      end
    else
      respond_to do |format|
        format.html { render layout: false }
        format.json { render :json => {data: "error" }, status: 500 }
      end
    end
  end

  def search
    if user_search_params.present? && user_search_params[:username].present? && user_search_params[:email].present?
      @users = User.by_username(user_search_params[:username]).by_email(user_search_params[:email])
      @user_search_params = user_search_params
    else
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
    params.require(:user).permit(:username, :password, :avi, :email, :from, :bio)
  end

  def user_search_params
    if params.has_key?(:user)
      params.require(:user)
    end
  end

  def user_id
    params[:id]
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
