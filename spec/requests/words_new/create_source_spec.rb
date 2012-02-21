require 'spec_helper'

describe "Words" do
  before(:each) do
    create_admin(:email=>'admin@example.com')
    login('admin@example.com')
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

    it "adds a definition to the databse" do
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
end
