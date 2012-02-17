require 'spec_helper'

describe "Sources" do
  context "index, create" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      visit sources_path
      fill_in 'Name', with:'NE'
    end

    it "adds a source to the database" do
      lambda do
        click_button 'Create Source'
      end.should change(Source,:count).by(1)
    end

    it "sets the name of the source" do
      click_button 'Create Source'
      Source.last.name.should eq 'NE'
    end

    it "redirect to the sources index page" do
      click_button 'Create Source'
      current_path.should eq sources_path
    end

    it "shows a notice flash message" do
      click_button 'Create Source'
      page.should have_notice('Source was successfully created.')
    end

    context "errors" do
      it "name cannot be blank" do
        fill_in 'Name', with:''
        click_button 'Create Source'
        li(:name).should have_blank_error
      end

      it "name must be unique" do
        Factory(:source,name:'NE')
        click_button 'Create Source'
        li(:name).should have_duplication_error
      end
    end
  end
end
