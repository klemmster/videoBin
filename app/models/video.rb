# == Schema Information
# Schema version: 20110406150351
#
# Table name: videos
#
#  id                    :integer         not null, primary key
#  name                  :string(255)
#  description           :text
#  length                :integer
#  created_at            :datetime
#  updated_at            :datetime
#  origfile_file_name    :string(255)
#  origfile_content_type :string(255)
#  origfile_file_size    :integer
#  origfile_updated_at   :datetime
#  doneConverting        :boolean
#  user_id               :integer
#

require 'lib/paperclip_processors/video_thumbnail'
require 'lib/paperclip_processors/video_converter'

class Video < ActiveRecord::Base
  attr_accessible :name, :description, :origfile
  attr_accessor :origfile
  belongs_to :user

  validates :name, :presence =>true
  validates :description, :presence => true
  validates_attachment_presence :origfile #Validation from paperclip

  has_attached_file :origfile, :styles => { :small => ['36x36#', :png],
                                            :medium => ['72x72#', :png],
                                            :large => ['640x320#', :png],
                                            :ogvvideo => { :processors => [:video_converter],
                                                            :format => 'ogv', :whiny => true },
                                            :webmvideo => { :processors => [:video_converter],
                                                            :format => 'webm', :whiny => true },
                                            :x264video => { :processors => [:video_converter],
                                                            :format => 'mp4', :whiny => true }
                                           },
                                :processors => [:video_thumbnail ]

  process_in_background :origfile
  before_post_process :done_uploading
  after_post_process :done_converting
  before_destroy :remove_attachments

  def isDoneConverting?
    self.doneConverting
  end


  protected
    def remove_attachments
      #TODO
    end
  private
    def done_uploading
      #flash[:success] = "Video Uploaded"
    end

    def done_converting
      self.doneConverting = true
      #flash[:success] = " Done converting Video"

    end
end
