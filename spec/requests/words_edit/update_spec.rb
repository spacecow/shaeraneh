require 'spec_helper'

describe "Words" do
  describe "edit" do
    context "update, word with one definition" do
      before(:each) do
        create_admin(:email=>'admin@example.com')
        login('admin@example.com')
        word = create_word("cat","has a tail")
        visit edit_word_path(word) 
        fill_in 'Word', with:'dog'
        fill_in 'Definition', with:'barks a lot'
      end

      it "does not add a word to the database" do
        lambda do
          click_button 'Update Word'
        end.should change(Word,:count).by(0)
      end

      it "changes the word" do
        click_button 'Update Word'
        Word.last.name.should eq 'dog'
      end

      it "changes the definition" do
        click_button 'Update Word'
        Word.last.definitions.should eq [Definition.last]
        Definition.last.content.should eq 'barks a lot'
      end

      it "redirects to the word index page" do
        click_button 'Update Word'
        current_path.should eq words_path
      end

      it "checking the box removes the definition" do
        check 'Remove Definition'
        lambda do
          click_button 'Update Word'
        end.should change(Definition,:count).by(-1)
      end
    end
  end
end
