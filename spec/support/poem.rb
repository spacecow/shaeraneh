def create_poem(*a)
  poem = Factory(:poem)
  a.each do |verse|
    poem.verses << create_verse(verse)
  end
  poem
end
