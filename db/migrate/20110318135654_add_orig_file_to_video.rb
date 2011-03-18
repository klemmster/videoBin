class AddOrigFileToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :origfile_file_name, :string
    add_column :videos, :origfile_content_type, :string
    add_column :videos, :origfile_file_size, :integer
    add_column :videos, :origfile_updated_at, :datetime
  end

  def self.down
    remove_column :videos, :origfile_updated_at
    remove_column :videos, :origfile_file_size
    remove_column :videos, :origfile_content_type
    remove_column :videos, :origfile_file_name
  end
end
