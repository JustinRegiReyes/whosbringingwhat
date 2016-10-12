class WelcomeController < ApplicationController
  def index
  	@user = User.new
  	if current_user != nil
  		redirect_to "/home"
  	end
  end
end
