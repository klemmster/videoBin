module ApplicationHelper
# Return a title on a per-page basis.

  def title
    if @title.nil?
      "Tutorial, an unknown Page"
    else
       "Tutorial, the #{@title} Page"
    end
  end
end
