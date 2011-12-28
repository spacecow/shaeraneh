def create_verse(s,i=nil)
  i = Verse.count if i.nil?
  Factory(:verse,:content=>s,:pos=>i) 
end
