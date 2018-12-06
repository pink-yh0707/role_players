module ApplicationHelper
  def full_title(sub_title = "")
    base_title = "Role Players"

    if sub_title.empty?
      base_title
    else
      "#{base_title} | #{sub_title}"
    end
  end

  def alert_color(type)
    case type
    when "success"
      "success"
    when "error"
      "danger"
    when "alert"
      "danger"
    when "notice"
      "info"
    else
      type.to_s
    end
  end
end
