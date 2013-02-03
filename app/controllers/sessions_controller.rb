class SessionsController < ApplicationController

  skip_before_filter :check_authentication, :only => [:new, :create]
  skip_before_filter :current_user, :only => [:new, :create]

  def new
  end

  def create
    user = User.authenticate( params[:username], params[:password] )
    unless user.nil?
      session[:user_id] = user.id
      redirect_to games_path
    else
      flash[:alert] = "There was an error logging you in. Try again."
      redirect_to new_session_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You've been logged out."
  end

end
