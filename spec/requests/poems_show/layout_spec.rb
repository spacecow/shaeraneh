# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Poems, show:" do
  before(:each) do
    @poem = create_poem('what is alpha','beta','gamma')
  end

  it "member list verses" do
    visit poem_path(@poem)
    tablerow(0).should eq ["what is alpha"]
    tablerow(1).should eq ["beta"]
    tablerow(2).should eq ["gamma"]
  end

  it "admin list verses" do
    login_admin
    visit poem_path(@poem)
    tablerow(0).should eq ["what is alpha","","▼"]
    tablerow(1).should eq ["beta","▲" ,"▼"]
    tablerow(2).should eq ["gamma","▲" ,""]
  end

  context "member layout with lookups" do
    before(:each) do
      word = create_word('alpha') 
      @poem.verses.first.lookups << Lookup.create(word_id:word.id, name:'alpha')
      visit poem_path(@poem)
    end

    it "has a link to a defined word" do
      row(0).should have_link('alpha')
    end
  end
end
