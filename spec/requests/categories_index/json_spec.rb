require 'spec_helper'

describe "Categories" do
  context "index, json without categories" do
    before(:each){ visit categories_path(:format => :json) }

    it "shows an empty array" do
      page.should have_content([].to_json)
    end
  end

  context "index, json with a category, no search" do
    before(:each) do
      @cat = Factory(:category,name_ir:'cat')
      visit categories_path(:format => :json) 
    end

    it "shows the one category" do
      page.text.should have_content("\"name\":\"cat\"")
    end
  end

  context "index, json with a category, fail on search" do
    before(:each) do
      @cat = Factory(:category,name_ir:'cat')
      visit categories_path(:format => :json, :q => "dog") 
    end

    it "shows the one category" do
      page.text.should_not have_content("\"name\":\"cat\"")
    end
  end
end
