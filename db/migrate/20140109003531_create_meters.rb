class CreateMeters < ActiveRecord::Migration
  def change
    create_table :meters do |t|
      t.string :meter_mac, unique: true

      t.timestamps
    end
  end
end
