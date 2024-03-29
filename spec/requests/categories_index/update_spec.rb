require 'spec_helper'

describe "Categories" do
  context "index, update" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      programming = create_category('programming')
      @ruby = create_category('ruby')
      create_category('io',programming.id)
      visit categories_path
      div(:category,0).click_link('Edit')
      find_field('Name').value.should eq 'programming'
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
      Category.all.map(&:name_ir).should eq ['red','ruby','io']
    end

    it "updates the names_depth_cache of the category" do
      click_button 'Update Category'
      Category.all.map(&:names_depth_cache_ir).should eq [Category.separate(I18n.locale,'ruby','red'),'ruby',Category.separate(I18n.locale,'ruby','red','io')]
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
        li(:name_ir).should have_duplication_error        
      end
    end
  end
end
