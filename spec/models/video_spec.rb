require 'spec_helper'

describe Video do
  before(:each) do
    @attr = { :name => "TestVideo",
              :description => "Wirklich nur ein sinnloses Video",
              :length => 400,
              :hrefs => ["TestVideo.ogg", "TestVideo.mp4"]
            }
  end
  
  it "should create a new instance given valid arguments" do
    Video.create!(@attr)
  end
  
  it "should require a name" do
    no_name_video = Video.new(@attr.merge(:name => ""))
    no_name_video.should_not be_valid
  end

  it "should require a description" do
    no_desc_video = Video.new(@attr.merge(:description => ""))
    no_desc_video.should_not be_valid
  end

  it "should have a length" do
    no_length_video = Video.new(@attr.merge(:length => 0))
    no_length_video.should_not be_valid
  end

end
