require 'spec_helper'

describe "Sources" do
  context "index, member layout" do
    before(:each){ visit sources_path }

    it "has a title" do
      page.should have_title('Sources')
    end

    it "has no sources div" do
      page.should_not have_div(:sources)
    end

    it "has no form subtitle" do
      page.should_not have_subtitle('New Source')
    end
  end

  context "index, admin layout" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      visit sources_path
    end

    it "has a subtitle" do
      page.should have_subtitle('New Source')
    end

    it "name field is emtpy" do
      value('Name').should be_nil
    end

    it "has a create source button" do
      page.should have_button('Create Source')
    end
  end

  context "index, member layout with sources" do
    before(:each) do
      Factory(:source,name:'NE')
      visit sources_path
    end

    it "has a sources div" do
      page.should have_div(:sources)
    end

    it "has a source class div" do
      div(:sources).divs_no(:source).should be(1)
    end

    it "show the name of the source" do
      div(:source,0).div(:name).should have_content('NE')
    end

    it "source has no edit link" do
      div(:source,0).div(:actions).should_not have_link('Edit')
    end
  end

  context "index, admin layout with sources" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      @ne = Factory(:source,name:'NE')
      visit sources_path
    end

    it "source has an edit link" do
      div(:source,0).div(:actions).should have_link('Edit')
    end
  end
end
