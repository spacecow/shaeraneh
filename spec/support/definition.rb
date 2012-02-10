def create_definition(s)
  Factory(:definition,:content=>s)
end

def create_form(s)
  Factory(:form,:name=>s)
end
