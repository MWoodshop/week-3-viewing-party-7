class ViewingPartiesController < ApplicationController
  def new
    if session[:user_id].nil? || session[:user_id].to_i != params[:user_id].to_i
      flash[:error] = 'You must be logged in or registered to create a movie party.'
      redirect_to user_movie_path(params[:user_id], params[:movie_id])
      return
    end
    @user = User.find(params[:user_id])
    @movie = Movie.find(params[:movie_id])
  end

  def create
    user = User.find(params[:user_id])
    user.viewing_parties.create(viewing_party_params)
    redirect_to "/users/#{params[:user_id]}"
  end

  private

  def viewing_party_params
    params.permit(:movie_id, :duration, :date, :time)
  end
end
