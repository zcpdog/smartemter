class MeterRecordsController < ApplicationController
  def index
    @meter = Meter.find(params[:meter_id])
    @meter_records = MeterRecord.produced_by(@meter).recent
    respond_to do |format|
      format.html
    end
  end
  
  def monitor
    @meter = Meter.find(params[:meter_id])
    @meter_record = MeterRecord.unread.produced_by(@meter).order("RAND()").last
    render json: @meter_record
  end
  
  def summary
    @meter = Meter.find(params[:meter_id])
    @meter_records = MeterRecord.produced_by(@meter).between(params[:begin_at],params[:end_at]);
    respond_to do |format|
      format.html
    end
  end
end
