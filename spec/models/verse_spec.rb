require 'spec_helper'

describe Verse do
  context "#lookup", solr:true do
    it "match of word in the beginning" do
      create_verse("dog day")
      Sunspot.commit
      search = Verse.lookup("dog") 
      search.results.should eq [Verse.last]
    end

    it "match of word in the middle" do
      create_verse("a dog day")
      Sunspot.commit
      search = Verse.lookup("dog") 
      search.results.should eq [Verse.last]
    end

    it "match of word in the end" do
      create_verse("a dog")
      Sunspot.commit
      search = Verse.lookup("dog")
      search.results.should eq [Verse.last]
    end

    it "it has to match the whole word" do
      create_verse("a doggy world")
      Sunspot.commit
      search = Verse.lookup("dog") 
      search.results.should be_empty 
    end
  end
end
