require 'spec_helper'

describe "Categories" do
  before(:each) do
    @ruby = create_category('ruby')
  end

  context "show, member layout" do
    before(:each) do
      visit category_path(@ruby)
    end 

    it "page has a title" do
      page.should have_title('ruby') 
    end

    it "has no edit link" do
      bottom_links.should_not have_link('Edit')
    end

    it "has no delete link" do
      bottom_links.should_not have_link('Delete')
    end
  end

  context "admin layout" do
    before(:each) do
      login_admin
      visit category_path(@ruby)
    end
    
    it "has an edit link" do
      bottom_links.should have_link('Edit')
    end

    it "has a delete link" do
      bottom_links.should have_link('Delete')
    end
  end
end
