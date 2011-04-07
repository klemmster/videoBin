module ApplicationHelper
# Return a title on a per-page basis.

  def title
    if @title.nil?
      "VideoBin"
    else
       "VideoBin, the #{@title} Page"
    end
  end

   def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
    end

end
