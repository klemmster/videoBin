# == Schema Information
# Schema version: 20110322195225
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
#

# == Schema Information
# Schema version: 20110318152401
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
#
require 'lib/paperclip_processors/video_thumbnail'
require 'lib/paperclip_processors/video_converter'

class Video < ActiveRecord::Base
  attr_accessible :name, :description, :origfile
  attr_accessor :origfile

  validates :name, :presence =>true
  validates :description, :presence => true
  validates_attachment_presence :origfile #Validation from paperclip

  has_attached_file :origfile, :styles => { :small => ['36x36#', :png],
                                            :medium => ['72x72#', :png],
                                            :large => ['115x115#', :png],
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

  def isDoneConverting?
    self.doneConverting
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
