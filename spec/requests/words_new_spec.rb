require 'spec_helper'

describe "Words" do
  describe "new" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      visit new_word_path
    end

    context "create word" do
      before(:each) do
        fill_in 'Word', :with => 'dog'
        fill_in 'Definition', :with => 'animal'
      end

      context "error" do
        it "words cannot be blank" do
          fill_in 'Word', :with => ''
          click_button 'Create Word'
          li(:word).should have_blank_error
        end
      end
    end
  end
end
