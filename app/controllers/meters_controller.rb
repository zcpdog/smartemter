class MetersController < ApplicationController
  def index
    @meters = Meter.all 
  end
  
  def show
    @meter = Meter.find(params[:id])
    
  end  
  
  def status
    @meter = Meter.find(params[:id])
    @date_range = params[:date_range].to_i || 1
    @meter_records = @meter.meter_records.between(Time.now-MeterRecord::DATE_ARRAY[@date_range],Time.now)
  end
  
  def giagonostic
    @meter = Meter.find(params[:id])
    @date_range = params[:date_range].to_i || 1
    @meter_records = @meter.meter_records.between(Time.now-MeterRecord::DATE_ARRAY[@date_range],Time.now)
  end
  
  def summary
    @meter = Meter.find(params[:id])
    @date_range = params[:date_range].to_i || 1
    @meter_records = @meter.meter_records.between(Time.now-MeterRecord::DATE_ARRAY[@date_range],Time.now)
  end
end
