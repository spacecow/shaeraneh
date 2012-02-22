def create_word(s,*opt)
  word = Factory(:word,:name=>s)
  if opt.first.instance_of? Array
    opt.each_with_index do |mdl,i|
      mdl.each do |e|
        if i==0
          word.definitions << create_definition(e) 
        elsif i==1
          word.forms << create_form(e) 
        end 
      end
    end
  else
    opt.each do |e|
      word.definitions << create_definition(e) 
    end
  end
  word
end

def fill_in_owner
  visit new_word_path
  fill_in 'Word',with:'dog'
end
