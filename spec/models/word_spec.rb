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
      it "adds a lookup to the database" do
        Sunspot.commit
        lambda do
          Factory(:word,name:"cat")
        end.should change(Lookup,:count).by(1)
      end

      it "adds an association to a verse" do
        Sunspot.commit
        word = Factory(:word,name:'cat')
        word.verses.should_not be_empty
        word.verses.should eq [Verse.last]
        word.lookups.should_not be_empty
        word.lookups.should eq [Lookup.last]
      end

      it "sets the name in the lookup" do
        Sunspot.commit
        Factory(:word,name:"cat")
        Lookup.last.name.should eq 'cat'
      end 
    end

    it "adds a lookup to the database on update", solr:true do
      Sunspot.commit
      lambda do
        @word = Factory(:word,name:"dog")
      end.should change(Lookup,:count).by(0)
      lambda do
        @word.update_attribute(:name,'cat')
      end.should change(Lookup,:count).by(1)
    end

    it "adds a lookup to the database on create/update", solr:true, focus:true do
      Sunspot.commit
      lambda do
        @word = Factory(:word,name:"cat")
      end.should change(Lookup,:count).by(1)
      Sunspot.commit
      lambda do
        @word.update_attribute(:name,'roof')
      end.should change(Lookup,:count).by(1)
      @word.verses.length.should be(1)
    end
  end
end
