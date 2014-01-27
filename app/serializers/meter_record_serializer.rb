class MeterRecordSerializer < ActiveModel::Serializer
  attributes :id, :Voltage_V, :Current_A, :Power_W, :Energy_kWH, :created_at
end
