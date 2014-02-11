module MeterRecordsHelper
  def init_data type
    MeterRecord.recent.map{|mr|"[#{mr.created_at.strftime('%s')},#{eval("mr."+type)}]"}.join(",")
  end
  
  def show_summary(bt,et)
    current = 0
    flage = false
    data = Array.new
    MeterRecord.between(bt,et).each do |mr|
      if(flage) 
        current+=mr.Energy_kWH
        data.push current
      else
        data.push mr.Energy_kWH
      end
    end
    "[#{data.join(',')}]"
  end
  
  def summary_time
    MeterRecord.first.created_at || Time.new
  end
  
  def show_summary_temp(mrs)
    data = Array.new
    current = 0
    pre =0
    mrs.each do |mr|
      cu = mr.Energy_kWH
      if(cu<pre) 
        current = cu
      else
        current = cu-pre
      end
      pre = mr.Energy_kWH
      data.push ((data.last||0)+current)
    end
    "[#{data.join(',')}]"
  end
  
end
