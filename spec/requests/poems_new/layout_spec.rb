require 'spec_helper'

describe "Poems" do
  describe "new, layout" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      visit new_poem_path
    end

    it "has a title" do
      page.should have_title("New Poem")
    end

    it "has a blank content field" do
      value('Content').should be_blank 
    end

  end
end
