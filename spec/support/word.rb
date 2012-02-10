def create_word(s,*defs)
  word = Factory(:word,:name=>s)
  defs.each do |definition|
    word.definitions << Factory(:definition,:content=>definition)
  end
end
