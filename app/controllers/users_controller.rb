class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    if session[:user_id].nil? || session[:user_id].to_i != params[:id].to_i
      flash[:error] = 'You must be logged in or registered to access your dashboard.'
      redirect_to root_path
      return
    end
    @user = User.find(params[:id])
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
