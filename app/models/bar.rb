class Bar < ActiveRecord::Base

  has_many :bar_distances, foreign_key: :start_bar_id

  validates_uniqueness_of :address
  validates_uniqueness_of :name

  #def closest_bars(num_bars=1)
  #  self.bar_distances.order(:distance).slice(0..(num_bars-2))
  #end

  def self.search_bars(lat, long, num_bars=1)
    dtor = Math::PI/180
    r = 3959

    rlat1 = lat * dtor
    rlong1 = long * dtor

    bars = self.all  # Find all the bars

    bar_distances = bars.map do |bar| # For each bar in the database
      rlat2 = bar.lat* dtor
      rlong2 = bar.long * dtor

      dlon = rlong1 - rlong2
      dlat = rlat1 - rlat2

      a = (Math::sin(dlat/2) ** 2) + Math::cos(rlat1) * Math::cos(rlat2) * (Math::sin(dlon/2) ** 2)
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
      d = r * c

      {
        distance: d,
        id: bar.id
      }
    end

    bar_distances.sort! { |x,y| x[:distance] <=> y[:distance] }

    closest_bars_hashes = bar_distances.slice(0..(num_bars-1))

    closest_bars_hashes.map {|bar_data|  self.find( bar_data[:id] ) }
  end

  def welcome
    # render welcome page
  end

  # def haversine(lat1, long1, lat2, long2)
  #   dtor = Math::PI/180
  #   r = 3959
  #
  #   rlat1 = lat1 * dtor
  #   rlong1 = long1 * dtor
  #   rlat2 = lat2 * dtor
  #   rlong2 = long2 * dtor
  #
  #   dlon = rlong1 - rlong2
  #   dlat = rlat1 - rlat2
  #
  #   a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
  #   c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
  #   d = r * c
  #
  #   return d
  # end
#######################################
#matt
  def self.user_location
    data[:lat] = lat
    data[:long] = long
    return data.to_json
  end
#####################################
  def self.closest_bar(lat, long)

    bars = Bar.all

    person_location = {lat: lat, long: long}

    min_distance = 100 # Start at 100 miles
    bar_id = nil

    bar_distances = bars.map do |b|
      distance = self.search( person_location[:lat].to_f, person_location[:long].to_f, b.lat.to_f, b.long.to_f)
      if min_distance > distance
        min_distance = distance
        bar_id = b.id
      end
    end

    bar = Bar.find(bar_id)

    data = {}
    data[:bar] = bar
    data[:closest_bars] = bar.closest_bars( 4 )

    return data.to_json

  end

  def to_s
    self.name
  end

end



# Bar.search(41, -87, 4)
