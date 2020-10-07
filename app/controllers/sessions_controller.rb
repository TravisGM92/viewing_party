class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You successfully logged in."
      redirect_to '/dashboard'
    else
      flash[:error] = "Sorry, your credentials are bad."
      redirect_to '/login'
    end
  end
end