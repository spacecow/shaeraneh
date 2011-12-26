require 'spec_helper'

describe Poem do
  describe "#after_add" do
    before(:each) do
      @poem = Factory(:poem)
    end

    context "caches" do
      before(:each) do
        @poem.verses << create_verse("1st")
      end

      it "verse content in poetry" do
      end

      it "caches only the first verse content" do
        @poem.verses << Factory(:verse,:content=>"2nd")
      end

      after(:each) do
        @poem.first_verse.should eq "1st"     
      end
    end

    context "removes cached verse" do
      before(:each) do
        @verse = create_verse("1st")
        @poem.verses << @verse
      end

      it "when no verses are left" do
        @poem.verses.destroy(@verse)
        @poem.first_verse.should eq "" 
      end

      it "not if there are other verses" do
        verse2 = create_verse("2nd")
        @poem.verses << verse2
        @poem.verses.destroy(verse2)
        @poem.first_verse.should eq "1st"
      end

      it "change if the first verse is deleted" do
        verse2 = create_verse("2nd")
        @poem.verses << verse2
        @poem.verses.destroy(@verse)
        @poem.first_verse.should eq "2nd"
      end
    end
  end
end
