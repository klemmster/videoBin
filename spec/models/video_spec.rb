require 'spec_helper'

describe Video do
  before(:each) do
    @attr = { :name => "TestVideo",
              :description => "Wirklich nur ein sinnloses Video",
              :length => 400,
            }
  end
  
  it "should create a new instance given valid arguments" do
    video = Video.new(@attr)
    video.origfile =  File.new(Rails.root + 'spec/fixtures/videos/oceans-clip.mp4')
    video.save
  end
  
  it "should require a name" do
    no_name_video = Video.new(@attr.merge(:name => ""))
    no_name_video.origfile = File.new(Rails.root + 'spec/fixtures/videos/oceans-clip.mp4')
    no_name_video.should_not be_valid
  end

  it "should require a description" do
    no_desc_video = Video.new(@attr.merge(:description => ""))
    no_desc_video.should_not be_valid
  end

end
