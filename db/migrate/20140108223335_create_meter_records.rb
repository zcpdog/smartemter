class CreateMeterRecords < ActiveRecord::Migration
  def change
    create_table :meter_records do |t|
      t.references :meter, index: true
      t.decimal :Voltage_V, precision: 8, scale: 2
      t.decimal :Current_A, precision: 8, scale: 2
      t.decimal :Power_W, precision: 8, scale: 2
      t.decimal :Energy_kWH, precision: 8, scale: 2

      t.timestamps
    end
  end
end
