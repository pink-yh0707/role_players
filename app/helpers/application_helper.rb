module ApplicationHelper
  def full_title(sub_title = "")
    base_title = "Role Players"

    if sub_title.empty?
      base_title
    else
      "#{base_title} | #{sub_title}"
    end
  end
end
