# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Poems, show:" do
  before(:each) do
    @poem = create_poem("what is alpha", "beta", "gamma")
  end

  context "with lookups, member links to" do
    before(:each) do
      @word = create_word('alpha') 
      @poem.verses.first.lookups << Lookup.create(word_id:@word.id, name:'alpha')
      visit poem_path(@poem)
    end

    it "defined word" do
      row(0).click_link 'alpha'
      current_path.should eq word_path(@word)
    end
  end

  context "change position" do
    before(:each) do
      login_admin
      visit poem_path(@poem)
    end

    it "descend verse" do
      row(1).click_link "▲"
    end
    it "ascend verse" do
      row(0).click_link "▼"
    end

    after(:each) do
      tablerow(0).should eq ["beta","","▼"]
      tablerow(1).should eq ["what is alpha","▲" ,"▼"]
      tablerow(2).should eq ["gamma","▲" ,""]
      Poem.last.first_verse.should eq "beta"
    end
  end
end
