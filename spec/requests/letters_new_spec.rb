require 'spec_helper'

describe "Letters" do
  describe "new" do
    it "layout" do
      visit new_letter_path
      page.should have_title("New Letter")
      find_field("Name").value.should be_nil
    end

    context "create a new letter" do
      before(:each) do
        visit new_letter_path
        fill_in "Name", :with => "a"
      end

      it "adds a letter to the database" do
        lambda do
          click_button "Create Letter"
        end.should change(Letter,:count).by(1)
      end

      it "saves name to the database" do
        click_button "Create Letter"
        Letter.last.name.should eq "a"
      end

      it "name cannot be blank" do
        fill_in "Name", :with => ""
        click_button "Create Letter" 
        li(:name).should have_blank_error
      end
    end
  end
end
