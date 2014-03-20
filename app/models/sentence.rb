class Sentence < ActiveRecord::Base
  validates_presence_of :name, :chapter, :verse
  validates_uniqueness_of :verse, scope: [:name, :chapter]
  searchable do
    text :content
  end
end
