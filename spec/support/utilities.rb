def full_title(page_title)

  def full_title(page_title)
    base_title = "Ruby on Rails Tutorial App"
    page_title.empty? ? base_title : "#{base_title} | #{page_title}"
  end

end