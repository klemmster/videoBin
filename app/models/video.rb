# == Schema Information
# Schema version: 20110317154909
#
# Table name: videos
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  length      :integer
#  hrefs       :string(255)     default("'--- []\n\n'")
#  created_at  :datetime
#  updated_at  :datetime
#

class Video < ActiveRecord::Base
  attr_accessible :name, :description, :length, :hrefs
  serialize :hrefs #, Array

  validates :length,
            :numericality => { :greater_than => 100}
  validates :name, :presence =>true
  validates :description, :presence => true
end
