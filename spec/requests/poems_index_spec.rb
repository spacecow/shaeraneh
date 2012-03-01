# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Poems" do
  describe "index" do
    context "member list poems" do
      before(:each) do
        poem = Factory(:poem)
        poem.verses << create_verse('betad')
      end

      it "poems are sorted alphabetically" do
        poem2 = Factory(:poem)
        poem2.verses << create_verse('alphac')
        visit poems_path
        tablemaps.first.should eq [['alphac','']]
        tablemaps.last.should eq [['betad','']]
      end

      it "poems starting with the same letter are grouped toghether" do
        poem2 = Factory(:poem)
        poem2.verses << create_verse('bobyd')
        visit poems_path
        tablemap.should eq [['betad',''],['bobyd','']]
      end
    end

    context "poems cannot end with" do
      before(:each) do
        @poem = Factory(:poem)
      end
   
      it "!" do 
        @poem.verses << create_verse("alpha!") 
      end

      it "؟" do
        @poem.verses << create_verse("alpha؟") 
      end

      it "\\s" do
        @poem.verses << create_verse("alpha ") 
      end

      after(:each) do
        visit poems_path
        tableheader.should eq ['a']
      end
    end
  end
end
