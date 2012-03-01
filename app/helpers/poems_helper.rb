module PoemsHelper
  def lookup_links(content,lookups)
    lookups.each do |lookup| 
      content.gsub!(/#{lookup.name}/, link_to(lookup.name,lookup.word))
    end
    content.html_safe
  end
end
