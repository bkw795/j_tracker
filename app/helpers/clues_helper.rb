module CluesHelper

  def clue_link( clue )
    if clue.clue_text.blank?
      "#{clue.value}"
    else
      "#{link_to clue.value, clue}<br /><br />#{clue.clue_text.html_safe}"
    end
  end

end
