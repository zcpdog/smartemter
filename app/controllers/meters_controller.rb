class MetersController < ApplicationController
  def index
    @meters = Meter.all 
  end
end
