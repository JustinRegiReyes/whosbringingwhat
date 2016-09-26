class SessionsController < ApplicationController

  def create #login
  	userParams = params.require(:user).permit(:email, :password)
  	@user = User.confirm(userParams)
  	if @user
  		login(@user)
  		redirect_to home_path
  	else
      flash[:auth_error] = "An account with that email and password has not been found."
  		redirect_to :back
  	end
  end

  def destroy
  	logout
  	redirect_to "/"
  end
end
