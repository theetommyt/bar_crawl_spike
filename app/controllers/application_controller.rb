class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # configure yelp one time
  require 'yelp'

  Yelp.client.configure do |config|

    config.consumer_key = 'zKxwCXDbroBjUewOAnClGg'
    config.consumer_secret = 'LqvVEq4K6e8MScO56lPSkJWhD-8'
    config.token = 'n92ejjebo3wO77v5QP2gEXkhvC63R6cd'
    config.token_secret = 'vVVuPh4XGPz_By5-3otyCUbaWwA'

  end

end
