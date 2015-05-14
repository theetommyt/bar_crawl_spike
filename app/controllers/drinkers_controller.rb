class DrinkersController < ApplicationController

  def index
    @drinkers = Drinker.all
  end

  def show
    @drinker = Drinker.find(params[:id])
  end

  def new
    @drinker = Drinker.new
  end
  def create
    drinker = Drinker.create ( drinker_params )
    redirect_to "/drinkers/#{ drinker.id }"
  end

  def edit
    @drinker = Drinker.find(params[:id])
  end
  def update
    drinker = Drinker.find(params[:id])
    drinker.update!( drinker_params )
    redirect_to "/drinkers/#{ drinker.id }"
  end

  def destroy
    Drinker.destroy(params[:id])
    redirect_to "/drinkers"
  end

  def profile
    authenticate!
    @drinker = current_user
  end

  def sign_in
    # render sign-in form here
  end

  private

  def drinker_params
    params.require(:drinker).permit(:name, :message)
  end

end
