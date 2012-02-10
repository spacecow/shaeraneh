require 'spec_helper'

describe "Words" do
  context "new, create word, 1 def., 2 forms" do
    before(:each) do
      visit new_word_path
      fill_in 'Word', :with => 'dog'
      fill_in 'Definition', :with => 'animal'
      fill_in 'Forms', :with => 'dogs, doggy'
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

    it "adds two forms to the database" do
      lambda do
        click_button 'Create Word'
      end.should change(Form,:count).by(2)
      Word.last.forms.should eq [Form.first,Form.last]
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

    it "if definition is blank, no definition is saved" do
      fill_in 'Definition', with:''
      lambda do
        click_button 'Create Word'
      end.should change(Definition,:count).by(0)
    end

    it "if two defintions are filled out, two are saved" do
      li(:content,1).fill_in('Definition',with:'has a tail')
      lambda do
        click_button 'Create Word'
      end.should change(Definition,:count).by(2)
    end
  end
end
