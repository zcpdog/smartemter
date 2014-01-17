class MeterRecordsController < ApplicationController
  def index
    @meter = Meter.find(params[:meter])
    @meter_records = MeterRecord.where(meter_id: @meter)
  end
end
