class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :name
      t.text :description
      t.integer :length
      t.string :href

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
