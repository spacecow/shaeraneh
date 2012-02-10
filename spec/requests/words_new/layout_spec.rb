
require 'spec_helper'

describe "Words" do
  context "new, layout, no last word" do
    before(:each){ visit new_word_path }

    it "has a title" do
      page.should have_title('New Word') 
    end
    it "word field should be empty" do
      value('Word').should be_nil
    end
    it "1st definition field should be empty" do
      value('Definition').should be_empty
    end
    it "2nd definition field should be empty" do
      value('Definition',1).should be_empty
    end
    it "there are two def. fields" do
      lis_no(:definition).should be(2)
    end
    it "has a create button" do
      page.should have_button('Create Word')
    end
    it "there should be a div for the last input word" do
      page.should have_div('last_word') 
    end
  end

  context "new, layout, last word" do
    it "shows the last input word on the top of the page with definition" do
      create_word('cat','has a tail')
      visit new_word_path
      div('last_word').div('word').should have_content('Word: cat')
      div('last_word').div('content').should have_content('Definition: has a tail')
    end

    it "shows the last input word on the top of the page without definition" do
      create_word('cat')
      visit new_word_path
      div('last_word').div('word').should have_content('Word: cat')
      div('last_word').should_not have_div('content')
    end
  end
end
