module MeterRecordsHelper
  def init_data type
    MeterRecord.recent.map{|mr|"[#{mr.created_at.strftime('%s')},#{eval("mr."+type)}]"}.join(",")
    ""
  end
end
