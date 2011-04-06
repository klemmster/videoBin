class AddOrigfileProcsessingToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :origfile_processing, :boolean
    remove_column :videos, :doneConverting
  end

  def self.down
    remove_column :videos, :origfile_processing
    add_column :videos, :doneConverting, :boolean
  end
end
