class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    if session[:drinker_id]
      @current_user = Drinker.find(session[:drinker_id])
    end
  end

  def authenticate!
    redirect_to '/' unless current_user
  end

end
