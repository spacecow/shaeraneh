# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Poems" do
  describe "show" do
    before(:each) do
      @poem = Factory(:poem)
      @poem.verses << create_verse("alpha")
      @poem.verses << create_verse("beta")
      @poem.verses << create_verse("gamma")
    end

    it "member list verses" do
      visit poem_path(@poem)
      tablerow(0).should eq ["alpha"]
      tablerow(1).should eq ["beta"]
      tablerow(2).should eq ["gamma"]
    end

    it "admin list verses" do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      visit poem_path(@poem)
      tablerow(0).should eq ["alpha","","▼"]
      tablerow(1).should eq ["beta","▲" ,"▼"]
      tablerow(2).should eq ["gamma","▲" ,""]
    end

    context "change position" do
      before(:each) do
        create_admin(:email=>'admin@example.com')
        login('admin@example.com')
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
        tablerow(1).should eq ["alpha","▲" ,"▼"]
        tablerow(2).should eq ["gamma","▲" ,""]
        Poem.last.first_verse.should eq "beta"
      end
    end
  end
end
