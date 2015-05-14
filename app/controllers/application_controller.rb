class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  require 'yelp'

  Yelp.client.configure do |config|

    config.consumer_key = 'zKxwCXDbroBjUewOAnClGg'
    config.consumer_secret = 'LqvVEq4K6e8MScO56lPSkJWh8'
    config.token = 'n92ejjebo3wO77v5QP2gEXkhvC63R6cd'
    config.token_secret = 'vVVuPh4XGPz_By3otyCUbaWwA'

  end

  def initialize

  end

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
