class WelcomeController < ApplicationController
  def index
    @users = User.all

    return unless request.path == '/dashboard' && session[:user_id].nil?

    flash[:error] = 'You must be logged in or registered to access your dashboard.'
    redirect_to root_path
  end
end
