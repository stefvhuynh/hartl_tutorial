module ApplicationHelper

  def full_title(page_title)
    base_title = "Ruby on Rails Tutorial App"
    page_title.empty? ? base_title : "#{base_title} | #{page_title}"
  end
  
  def authenticity_token
    <<-HTML.html_safe
      <input type="hidden" name="authenticity_token" 
        value="#{form_authenticity_token}">
    HTML
  end
  
end
