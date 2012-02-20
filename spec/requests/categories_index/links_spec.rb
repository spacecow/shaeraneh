require 'spec_helper'

describe "Categories" do
  context "index, admin edit link for category" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      Factory(:source,name:'NE')
      visit sources_path
      div(:source,0).div(:actions).click_link('Edit')
    end

    it "redirects to the index page" do
      current_path.should eq sources_path
    end

    it "has a subtitle" do
      page.should have_subtitle('Edit Source')
    end

    it "fills in the name field" do
      value('Name').should eq 'NE'
    end

    it "has an update source button" do
      page.should have_button('Update Source')
    end
  end
end
