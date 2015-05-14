
#search by geographical bounds:
# bounds=sw_latitude,sw_longitude|ne_latitude,ne_longitude
#example of request: http://api.yelp.com/v2/search?term=food&bounds=37.900000,-122.500000|37.788022,-122.399797&limit=3

#BUSINESS API
#request: /v2/business/{id}	GET	Lookup business information by id.
#example of request: http://api.yelp.com/v2/business/yelp-san-francisco

require 'yelp'

Yelp.client.configure do |config|

  config.consumer_key = 'zKxwCXDbroBjUewOAnClGg'
  config.consumer_secret = 'LqvVEq4K6e8MScO56lPSkJWhD-8'
  config.token = 'n92ejjebo3wO77v5QP2gEXkhvC63R6cd'
  config.token_secret = 'vVVuPh4XGPz_By5-3otyCUbaWwA'

end
Yelp.client.search('1600 pennsylvania avenue, dc')@hash[0][1]


# params = { term: 'tavern',
#             limit: 3,
#             category_filter: 'bars'
#           }
#
#
#
#
# coordinates = { latitude: 41.890814, longitude: -87.626700 }
#
# results = Yelp.client.search_by_coordinates(coordinates, params)



# results = Yelp.client.search('Chicago', params)
# puts re
