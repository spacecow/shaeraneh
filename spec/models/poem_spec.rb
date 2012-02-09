require 'spec_helper'

describe Poem do
  describe "#after_add" do
    before(:each) do
      @poem = Factory(:poem)
      @poem.verses << create_verse("1st")
    end

    it "caches verse content in poetry" do
    end

    it "caches only the first verse content" do
      @poem.verses << create_verse("2nd")
    end

    after(:each) do
      @poem.first_verse.should eq "1st"     
      @poem.initial.should eq "t"
    end
  end

  describe "#after_remove" do
    before(:each) do
      @poem = Factory(:poem)
      @verse = create_verse("1st")
      @poem.verses << @verse
    end

    it "removes cached verse when no verses are left" do
      @poem.verses.destroy(@verse)
      @poem.first_verse.should eq "" 
      @poem.initial.should eq "" 
    end

    it "does not remove cached verse if there are other verses" do
      verse2 = create_verse("2nd")
      @poem.verses << verse2
      @poem.verses.destroy(verse2)
      @poem.first_verse.should eq "1st"
      @poem.initial.should eq "t"
    end

    it "changes the cached verse if the first verse is deleted" do
      verse2 = create_verse("2nd")
      @poem.verses << verse2
      @poem.verses.destroy(@verse)
      @poem.first_verse.should eq "2nd"
      @poem.initial.should eq "d"
    end
  end
end
