require 'spec_helper'

describe "Categories" do
  context "index, update" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      Factory(:category,name:'programming')
      @ruby = Factory(:category,name:'ruby')
      visit categories_path
      div(:category,0).click_link('Edit')
      fill_in 'Name', with:'red'
      select 'ruby', from:'Parent'
    end

    it "does not change the count in the database" do
      lambda do
        click_button 'Update Category'
      end.should change(Category,:count).by(0)
    end

    it "updates the name of the category" do
      click_button 'Update Category'
      Category.first.name.should eq 'red'
    end

    it "updates the parent of the category" do
      click_button 'Update Category'
      Category.first.parent.should eq @ruby 
    end

    it "redirect to the categories index page" do
      click_button 'Update Category'
      current_path.should eq categories_path
    end

    it "shows a notice flash message" do
      click_button 'Update Category'
      page.should have_notice('Category was successfully updated.')
    end

    context "errors: " do
      it "name cannot be blank" do
        fill_in 'Name', with:''
        click_button 'Update Category'
        li(:name).should have_blank_error
      end
      
      it "name cannot be duplicated" do
        fill_in 'Name', with:'ruby'
        click_button 'Update Category'
        li(:name).should have_duplication_error        
      end
    end
  end
end