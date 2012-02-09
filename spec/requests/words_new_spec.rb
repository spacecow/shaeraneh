require 'spec_helper'

describe "Words" do
  describe "new" do
    before(:each){ visit new_word_path }

    context "layout" do
      it "has a title" do
        page.should have_title('New Word') 
      end
      it "word field should be empty" do
        value('Word').should be_nil
      end
      it "definition field should be empty" do
        value('Definition').should be_empty
      end
      it "there should be only one def. field"  do
        lis(:definition).count.should be(1)
      end
      it "has a create button" do
        page.should have_button('Create Word')
      end

      it "there should be a div for the last input word" do
        page.should have_div('last_word') 
      end
      it "shows the last input word on the top of the page" do
        create_word('cat','has a tail')
        visit new_word_path
        div('last_word').div('word').should have_content('Word: cat')
        div('last_word').div('content').should have_content('Definition: has a tail')
      end
    end

    context "create word" do
      before(:each) do
        fill_in 'Word', :with => 'dog'
        fill_in 'Definition', :with => 'animal'
      end

      it "adds a word to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Word,:count).by(1)
      end

      it "adds a definition to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Definition,:count).by(1)
      end

      it "adds a definition assoc. to the word" do
        click_button 'Create Word'
        Word.last.definitions.should eq [Definition.last]
      end

      it "saves the name of the word" do
        click_button 'Create Word'
        Word.last.name.should eq 'dog'
      end

      it "saves the content of the definition" do
        click_button 'Create Word'
        Definition.last.content.should eq 'animal'
      end

      it "redirects to the new word page" do
        click_button 'Create Word'
        current_path.should eq new_word_path
      end

      it "shows a flash message" do
        click_button 'Create Word'
        page.should have_notice('Word was successfully created.')
      end

      context "error" do
        it "words cannot be blank" do
          fill_in 'Word', :with => ''
          click_button 'Create Word'
          li(:word).should have_blank_error
        end

        it "definition cannot be blank" do
          fill_in 'Definition', :with => ''
          click_button 'Create Word'
          li(:definition).should have_blank_error
        end
      end
    end
  end
end
