class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.string   :name, index: true
      t.integer  :chapter, index: true
      t.integer  :verse, index: true
      t.string   :content
      t.string   :local
      
      t.timestamps
    end
  end
end
