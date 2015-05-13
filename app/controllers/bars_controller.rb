class BarsController < ApplicationController

  # def power(num, pow)
  #   num ** pow
  # end
  #

  def bar_crawl
    lat = 41.8907686 # params[:lat].to_f
    long = -87.62671089999999 # params[:long].to_f
    name = Faker::Name.first_name + " will " + Faker::Hacker.verb + " the " + Faker::Hacker.noun
    crawls = Crawl.brackets(name, lat, long, 3)
    bar_data = crawls.map{ |crawl| crawl.collect_bars }
    render json: {crawls: bar_data, name: name}
  end


  def welcome
    # render welcome page
  end

  def closest_bars
    bars = Bar.search_bars(params['lat'].to_f, params['long'].to_f, params['num_stops'].to_i)
    render json: bars
  end

  # def bar_crawl
  #   lat = 41.8907686 # params[:lat].to_f
  #   long = -87.62671089999999 # params[:long].to_f
  #   num_stops = (params[:num_stops] || 15).to_i
  #   bars = Bar.crawl(lat, long, num_stops)
  #
  #   render json: bars
  # end


  def index
    @bars = Bar.all
  end

  def api
    @bars = Bar.all
    render json: @bars
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

  #@bar = Bar.find(1)
  #@bar.search


end
