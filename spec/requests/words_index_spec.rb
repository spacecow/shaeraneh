require 'spec_helper'

describe "Words" do
  describe "index" do
    before(:each){ visit words_path }

    context "layout" do
      context "top links has links to" do
        it "creating a new word" do
          top_links.should have_link('New Word')
        end
      end 
      context "bottom links has links to" do
        it "creating a new word" do
          bottom_links.should have_link('New Word')
        end
      end 
    end #layout

    context "links to" do
      context "top links to" do
        it "creating a new word" do
          top_links.click_link 'New Word'
          current_path.should eq new_word_path
        end 
      end 
      context "bottom links to" do
        it "creating a new word" do
          bottom_links.click_link 'New Word'
          current_path.should eq new_word_path
        end 
      end 
    end #links to
  end
end
