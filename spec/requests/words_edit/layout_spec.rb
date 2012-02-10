require 'spec_helper'

describe "Words" do
  describe "edit" do
    context "layout, word with one definition" do
      before(:each) do
        word = create_word("cat","has a tail")
        visit edit_word_path(word) 
      end

      it "has a title" do
        page.should have_title("Edit Word")
      end

      it "the word field should be filled" do
        value('Word').should eq 'cat'
      end

      it "the definition field should be filled" do
        value('Definition').should eq 'has a tail'
      end

      it "has an update button" do
        page.should have_button('Update Word') 
      end
    end 
  end
end
