class Audio < ActiveRecord::Base
  has_attached_file :asset
  do_not_validate_attachment_file_type :asset
end
