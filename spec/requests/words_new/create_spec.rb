# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Words" do
  before(:each) do
    create_admin(:email=>'admin@example.com')
    login('admin@example.com')
  end

  context "new, create word and link to poem" do
    before(:each) do
      create_poem("a dog word","a doggy house")
      visit new_word_path
    end 

    it "by the word", solr:true do
      fill_in 'Word', :with => 'dog'
      lambda do
        click_button 'Create Word'
      end.should change(Lookup,:count).by(1)
    end

    it "by a form", solr:true do
      fill_in 'Word', :with => 'cat'
      fill_in 'Forms', :with => 'dogs, doggy'
      lambda do
        click_button 'Create Word'
      end.should change(Lookup,:count).by(1)
    end

    it "by a word and a form", solr:true do
      fill_in 'Word', :with => 'dog'
      fill_in 'Forms', :with => 'dogs, doggy'
      lambda do
        click_button 'Create Word'
      end.should change(Lookup,:count).by(2)
    end
  end #new, create word and link to poem

  context "new, create word, no definition" do
    before(:each) do
      visit new_word_path
      fill_in 'Word', :with => 'dog'
    end
    
    it "adds a word to the database" do
      lambda do
        click_button 'Create Word'
      end.should change(Word,:count).by(1)
    end

    it "adds no definition to the databse" do
      lambda do
        click_button 'Create Word'
      end.should change(Definition,:count).by(0)
    end

    context "errors" do
      before(:each) do
        fill_in 'Word', with:''
      end

      it "name cannot be blank" do
        click_button 'Create Word'
        li(:name).should have_blank_error
      end

      it "there are ten definition fields" do
        click_button 'Create Word'
        lis_no(:content).should be(10)
      end

      it "with a def filled in, there are still 10 def fields" do
        fill_in 'Definition', with:'animal'       
        click_button 'Create Word'  
        lis_no(:content).should be(10)
      end
    end
  end

  context "new, create word, a definition" do
    before(:each) do
      visit new_word_path
      fill_in 'Word', :with => 'dog'
      fill_in 'Definition', :with => 'animal'
    end
    
    it "adds a word to the database" do
      lambda do
        click_button 'Create Word'
      end.should change(Word,:count).by(1)
    end

    it "adds no definition to the databse" do
      lambda do
        click_button 'Create Word'
      end.should change(Definition,:count).by(1)
    end

    context "no source" do
      it "adds no source to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Source,:count).by(0)
      end
    end

    context "with existing source" do
      before(:each) do
        source = Factory(:source,name:'NE')
        fill_in 'Source', :with => source.id 
      end

      it "adds no source to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Source,:count).by(0)
      end

      it "connects the source to the definition" do
        click_button 'Create Word'
        Definition.last.source = Source.last
      end
    end

    context "with new source" do
      before(:each) do
        fill_in 'Source', :with => "NE" 
      end

      it "adds a source to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Source,:count).by(1)
      end

      it "connects the source to the definition" do
        click_button 'Create Word'
        Definition.last.source = Source.last
      end
    end

    context "with new source that already exists" do
      before(:each) do
        source = Factory(:source,name:'NE')
        fill_in 'Source', with:'NE' 
      end

      it "adds no source to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Source,:count).by(0)
      end

      it "connects the source to the definition" do
        click_button 'Create Word'
        Definition.last.source.should eq Source.last
      end
    end

    context "with new source with digits" do
      before(:each) do
        fill_in 'Source', with:'666' 
      end

      it "adds no source to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Source,:count).by(0)
      end

      it "definition source is nil" do
        click_button 'Create Word'
        Definition.last.source.should be_nil 
      end
    end
  end

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
