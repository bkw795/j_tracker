class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  before_filter :current_user
  before_filter :check_authentication

  def check_authentication
    unless session[:user_id]
      session[:intended_controller] = controller_name
      session[:intended_action] = action_name
      redirect_to login_url
    end
  end

  def current_user
    unless session[:user_id]
      redirect_to( new_session_path, :error => "You must log in to view this page." ) and return
    end
    @current_user ||= User.find( session[:user_id] )
  end

end
