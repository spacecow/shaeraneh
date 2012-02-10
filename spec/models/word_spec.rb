require 'spec_helper'

describe Word do
  it "deleting a word deletes its definitions as well" do
    word = create_word('cat',['has a tail'])
    lambda do
      word.destroy
    end.should change(Definition,:count).by(-1)
  end

  it "deleting a word deletes its forms as well" do
    word = create_word('cat',['has a tail'],['kitty'])
    lambda do
      word.destroy
    end.should change(Form,:count).by(-1)
  end
end
