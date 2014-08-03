module UsersHelper
  
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    # image_tag(gravatar_url, alt: user.name, class: "gravatar")
    <<-HTML.html_safe
      <img src="#{gravatar_url}" class="gravatar" alt="#{user.name}">
    HTML
  end
  
end
