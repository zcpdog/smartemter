class AddIsReadToMeterRecords < ActiveRecord::Migration
  def change
    add_column :meter_records, :is_read, :boolean, default: false
  end
end
