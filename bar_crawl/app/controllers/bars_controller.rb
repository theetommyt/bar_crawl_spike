class BarsController < ApplicationController

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
