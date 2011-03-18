class AddDoneConvertingToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :doneConverting, :boolean
  end

  def self.down
    remove_column :videos, :doneConverting
  end
end
