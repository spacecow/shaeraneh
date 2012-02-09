def create_word(_word,_definition)
  word = Factory(:word,:name=>_word)
  word.definitions << Factory(:definition,:content=>_definition)
end
