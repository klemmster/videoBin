class RenameHrefsToHref < ActiveRecord::Migration
  def self.up
    rename_column :videos, :hrefs, :href
  end

  def self.down
    rename_column :videos, :href, :hrefs
  end
end
