require 'spec_helper'

describe "Sources" do
  context "index, update" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      Factory(:source,name:'NE')
      visit sources_path
      div(:source,0).div(:actions).click_link('Edit')
      fill_in 'Name', with:'Brittania'
    end

    it "does not change the count in the database" do
      lambda do
        click_button 'Update Source'
      end.should change(Source,:count).by(0)
    end

    it "updates the name of the source" do
      click_button 'Update Source'
      Source.last.name.should eq 'Brittania'
    end

    it "redirect to the sources index page" do
      click_button 'Update Source'
      current_path.should eq sources_path
    end

    it "shows a notice flash message" do
      click_button 'Update Source'
      page.should have_notice('Source was successfully updated.')
    end

    context "errors" do
      it "name cannot be blank" do
        fill_in 'Name', with:''
        click_button 'Update Source'
        li(:name).should have_blank_error
      end

      it "name must be unique" do
        Factory(:source,name:'Brittania')
        click_button 'Update Source'
        li(:name).should have_duplication_error
      end
    end
  end
end
