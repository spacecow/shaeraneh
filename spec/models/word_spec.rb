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

  context "create links on save" do 
    before(:each) do
      create_poem('cat on the roof')
    end

    context "on create", solr:true do
      before(:each){ Sunspot.commit }

      it "adds a lookup to the database" do
        lambda do
          Factory(:word,name:"cat")
        end.should change(Lookup,:count).by(1)
      end

      it "adds an association to a verse" do
        word = Factory(:word,name:'cat')
        word.verses.should eq [Verse.last]
        word.lookups.should eq [Lookup.last]
      end

      it "sets the name in the lookup" do
        Factory(:word,name:"cat")
        Lookup.last.name.should eq 'cat'
      end 
    end

    context "on update", solr:true do
      before(:each) do
        @word = Factory(:word,name:"dog")
        Sunspot.commit
      end

      it "adds a lookup to the database" do
        lambda{ @word.update_attribute(:name,'cat')
        }.should change(Lookup,:count).by(1)
      end

      it "adds an association to a verse" do
        @word.update_attribute(:name,'cat')
        Word.last.verses.should eq [Verse.last]
        Word.last.lookups.should eq [Lookup.last]
      end

      it "sets the name in the lookup" do
        @word.update_attribute(:name,'cat')
        Lookup.last.name.should eq 'cat'
      end 
    end

    context "create/update", solr:true do
      before(:each) do
        Sunspot.commit
        lambda do
          @word = Factory(:word,name:"cat")
        end.should change(Lookup,:count).by(1)
        Sunspot.commit
      end

      it "replaces the lookup in the database" do
        lambda{ @word.update_attribute(:name,'roof')
        }.should change(Lookup,:count).by(0)
      end

      it "adds an association to a verse" do
        @word.update_attribute(:name,'roof')
        Word.last.verses.should eq [Verse.last]
        Word.last.lookups.should eq [Lookup.last]
      end

      it "sets the name in the lookup" do
        @word.update_attribute(:name,'roof')
        Lookup.last.name.should eq 'roof'
      end 
    end
  end
end
