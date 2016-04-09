class SessionsController < ApplicationController

  def create #login
  	userParams = params.require(:user).permit(:username, :password)
  	@user = User.confirm(userParams)
  	if @user
  		login(@user)
  		redirect_to home_path
  	else
      flash[:auth_error] = "An account with that username and password has not been found."
  		redirect_to :back
  	end
  end

  def destroy
  	logout
  	redirect_to "/"
  end
end
