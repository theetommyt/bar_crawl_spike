class YelpController < ApplicationController

def api

  location = params[:location]
  result = Yelp.client.search(location)
  result_geo = result.region.center
  render json: result_geo

end


end
