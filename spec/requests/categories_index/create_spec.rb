require 'spec_helper'

describe "Categories" do
  context "index, create" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      create_category('programming')
      visit categories_path
      fill_in 'Name', with:'ruby'
      select 'programming', from:'Parent'
    end

    it "adds a category to the database" do
      lambda do
        click_button 'Create Category'
      end.should change(Category,:count).by(1)
    end

    it "sets the name of the category" do
      click_button 'Create Category'
      Category.last.name(I18n.locale).should eq 'ruby'
    end

    it "sets the parent-children relation" do
      click_button 'Create Category'
      Category.first.children.should eq [Category.last]
      Category.last.parent.should eq Category.first
    end

    it "redirect to the categories index page" do
      click_button 'Create Category'
      current_path.should eq categories_path
    end

    it "shows a notice flash message" do
      click_button 'Create Category'
      page.should have_notice('Category was successfully created.')
    end

    context "errors: " do
      it "name cannot be blank" do
        fill_in 'Name', with:''
        click_button 'Create Category'
        li(:name).should have_blank_error
      end
      
      it "name cannot be duplicated" do
        create_category('ruby')
        click_button 'Create Category'
        li(:name_ir).should have_duplication_error        
      end
    end
  end
end
