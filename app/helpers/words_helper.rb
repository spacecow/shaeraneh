module WordsHelper
  def lookup_link(content, link, poem)
    content.gsub(/#{link}/, link_to(link,poem)).html_safe
  end
end
