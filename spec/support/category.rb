def create_category(s,id=nil) 
  if id.nil?
    Factory(:category, name_ir:s)
  else
    Factory(:category, name_ir:s, parent_id:id)
  end
end
