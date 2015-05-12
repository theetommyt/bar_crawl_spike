class BarsController < ApplicationController

  # def power(num, pow)
  #   num ** pow
  # end
  #
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


  def welcome
    # render welcome page
  end

  def closest_bar

    bars = Bar.all
    person_location = {lat: params['lat'], long:params['long']}

    min_distance = 100 # Start at 100 miles
    bar_id = nil

    bar_distances = bars.map do |b|
      distance = haversine(person_location[:lat].to_f, person_location[:long].to_f, b.lat.to_f, b.long.to_f)
      if min_distance > distance
        min_distance = distance
        bar_id = b.id
      end
    end

    bar = Bar.find(bar_id)

    data = {}
    data[:bar] = bar
    data[:closest_bars] = bar.closest_bars( 3 )

    render json: data

  end


  def index
    @bars = Bar.all
  end

  def show
    @bar = Bar.find(params[:id])
  end

  def new
    @bar = Bar.new
  end
  def create
    bar = Bar.create ( bar_params )
    redirect_to "/bars/#{ bar.id }"
  end

  def edit
    @bar = Bar.find(params[:id])
  end
  def update
    bar = Bar.find(params[:id])
    bar.update!( bar_params )
    redirect_to "/bar/#{ bar.id }"
  end

  def destroy
    Bar.destroy(params[:id])
    redirect_to "/bars"
  end

  private

  def bar_params
    params.require(:bar).permit(:name, :message)
  end


end
