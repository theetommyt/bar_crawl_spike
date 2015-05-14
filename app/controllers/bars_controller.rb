class BarsController < ApplicationController

  # def power(num, pow)
  #   num ** pow
  # end
  #
################################

  def bar_crawl

    lat = params[:lat].to_f
    #lat = 41.8907686 #params[:lat].to_f
    long = params[:long].to_f
    #long = -87.62671089999999 #params[:long].to_f
    num_bars = 4 #params[:num_bars].to_i

    name = Faker::Name.first_name + " will " + Faker::Hacker.verb + " the " + Faker::Hacker.noun
    crawls = Crawl.brackets(name, lat, long, num_bars)
    bar_data = crawls.map{ |crawl| crawl.collect_bars }

    rounds = bar_data[0].length.times.map do |idx|
      bar_data.map {|crawl| crawl[idx] }
    end

    possible_crawls = (0...(rounds[0].length)).to_a

    bracket = rounds.reverse.map do |round|
      bars = possible_crawls.map{|idx| round[idx] }
      possible_crawls.select!.each_with_index { |ele, i| i.even? }
      bars
    end.reverse

    render json: {crawls: bar_data, bracket: bracket, name: name}
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
