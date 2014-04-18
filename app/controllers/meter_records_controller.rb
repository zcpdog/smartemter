class MeterRecordsController < ApplicationController
  def index
    @meter = Meter.find(params[:meter_id])
    @meter_records = MeterRecord.produced_by(@meter).recent
    # respond_to do |format|
#       format.html
#     end
  end
  
  def monitor
    @meter = Meter.find(params[:meter_id])
    @meter_record = MeterRecord.produced_by(@meter).last
    render json: @meter_record
  end
  
  def summary
    @meter = Meter.find(params[:meter_id])
    @meter_records = MeterRecord.produced_by(@meter);
    respond_to do |format|
      format.html
      format.json {render @meter_records}
    end
  end
end
