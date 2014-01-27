class MetersController < ApplicationController
  def index
    @meters = Meter.all 
  end
  
  def show
    @meter = Meter.find(params[:id])
    respond_to do |format|
      format.json # index.html.erb
    end
  end
end
