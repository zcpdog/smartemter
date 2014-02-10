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
    current = 0
    flage = false
    data = Array.new
    max = 0
    low = 0;
    mrs.each do |mr|
      if mr.Energy_kWH>max
        max = mr.Energy_kWH
      else
        low = mr.Energy_kWH
        flage = true
      end
      if flage
        current+=(mr.Energy_kWH-low)
        data.push current
      else
        data.push mr.Energy_kWH
      end
    end
    "[#{data.join(',')}]"
  end
  
end
