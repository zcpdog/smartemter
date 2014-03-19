class MeterRecord < ActiveRecord::Base
  belongs_to :meters
  scope :produced_by, ->(meter) { where(meter_id: meter)}
  scope :unread, ->{where(is_read: false)}
  scope :recent, ->{last(20)}
  scope :between, ->(begin_at,end_at){where(created_at: [begin_at..end_at])}
  
  DATE_ARRAY = [0.minutes,1.minute,5.minutes,1.hour,24.hours,30.days,60.days]
end
