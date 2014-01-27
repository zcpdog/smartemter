class MeterRecord < ActiveRecord::Base
  belongs_to :meters
  scope :produced_by, ->(meter) { where(meter_id: meter)}
  scope :unread, ->{where(is_read: false)}
  scope :recent, ->{last(20)}
  scope :between, ->(begin_at,end_at){where(created_at: [begin_at..end_at])}
end
