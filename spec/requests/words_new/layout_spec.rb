require 'spec_helper'

describe "Words" do
  before(:each) do
    create_admin(:email=>'admin@example.com')
    login('admin@example.com')
  end

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
    it "there are two definition fields" do
      lis_no(:content).should be(2)
    end

    it "has a 1st blank source field" do
      value('Source').should be_blank 
    end
    it "has a 2nd blank source field" do
      value('Source',1).should be_blank 
    end
    it "there are two source fields" do
      lis_no(:source).should be(2)
    end

    it "has a form field" do
      value('Forms').should be_nil
    end
    it "has a create button" do
      page.should have_button('Create Word')
    end
    it "there should be a div for the last input word" do
      page.should have_div('last_word') 
    end
  end

  #context "new, layout, last word" do
  #  it "shows the last input word on the top of the page with definition" do
  #    create_word('cat','has a tail')
  #    visit new_word_path
  #    div('last_word').div('word').should have_content('Word: cat')
  #    div('last_word').div('word').should_not have_content('Word: cat,')
  #    div('last_word').div('content').should have_content('Definition: has a tail')
  #  end

  #  it "shows the last input word on the top of the page with definition and form" do
  #    create_word('cat',['has a tail'],['kitten'])
  #    visit new_word_path
  #    div('last_word').div('word').should have_content('Word: cat, kitten')
  #    div('last_word').div('content').should have_content('Definition: has a tail')
  #  end

  #  it "shows the last input word on the top of the page with definition, form and links"

  #  it "shows the last input word on the top of the page without definition" do
  #    create_word('cat')
  #    visit new_word_path
  #    div('last_word').div('word').should have_content('Word: cat')
  #    div('last_word').should_not have_div('content')
  #  end
  #end
end
