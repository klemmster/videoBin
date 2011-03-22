# == Schema Information
# Schema version: 20110318152401
#
# Table name: videos
#
#  id                    :integer         not null, primary key
#  name                  :string(255)
#  description           :text
#  length                :integer
#  href                  :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  origfile_file_name    :string(255)
#  origfile_content_type :string(255)
#  origfile_file_size    :integer
#  origfile_updated_at   :datetime
#  doneConverting        :boolean
#

class Video < ActiveRecord::Base
  attr_accessible :name, :description, :href, :origfile
  attr_accessor :origfile

  validates :name, :presence =>true
  validates :description, :presence => true
  validates_attachment_presence :origfile #Validation from paperclip

  has_attached_file :origfile, :styles => {}
  
  before_post_process :confirm_upload
  after_post_process :confirm_converting_done
  after_create :generateVideoBaseUrl

  def isDoneConverting?
    self.doneConverting
  end


  private
    def confirm_upload
      #TODO: Inform user about successful upload, conversion started
    end

    def confirm_converting_done
      #self.doneConverting = true
      #TODO: Possibly inform user
    end
  def generateVideoBaseUrl
    self.href = Rails.public_path + '/system/origfiles/' + self.id.to_s 
    #TODO: Fix URL to Converted
  end
    
end
