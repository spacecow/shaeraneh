require 'spec_helper'

describe "Categories" do
  context "index, delete root category without children" do
    before(:each) do
      login_admin
      Factory(:category,name:'islam')
      #programming = Factory(:category,name:'programming')
      #Factory(:category, name:'io', parent_id:programming.id)
      visit categories_path
    end

    it "decreases count in the database" do
      lambda do
        div('category',0).click_link 'Del'
      end.should change(Category,:count).by(-1)
    end

    it "redirects to the category index page" do
      div('category',0).click_link 'Del'
      current_path.should eq categories_path
    end

    it "shows a notice flash message" do
      div('category',0).click_link 'Del'
      page.should have_notice('Category was successfully deleted.')
    end
  end

  context "index, delete root category with children" do
    before(:each) do
      login_admin
      programming = Factory(:category,name:'programming')
      Factory(:category, name:'io', parent_id:programming.id)
      visit categories_path
    end

    it "lists the name of the category" do
      div('category',0).should have_content('programming')
    end

    it "decreases count in the database" do
      lambda do
        div('category',0).click_link 'Del'
      end.should change(Category,:count).by(-1)
    end

    it "children gets their names_depth_cache updated" do
      div('category',0).click_link 'Del'
      Category.last.names_depth_cache_ir.should eq 'io'
    end
  end
end
