class AddAttachmentAssetToAudios < ActiveRecord::Migration
  def self.up
    change_table :audios do |t|
      t.attachment :asset
    end
  end

  def self.down
    drop_attached_file :audios, :asset
  end
end
