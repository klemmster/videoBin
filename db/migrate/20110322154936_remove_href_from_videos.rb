class RemoveHrefFromVideos < ActiveRecord::Migration
  def self.up
    remove_column :videos, :href
  end

  def self.down
    add_column :videos, :href, :videos
  end
end
