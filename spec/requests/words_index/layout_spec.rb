require 'spec_helper'

describe "Words" do
  describe "index" do
    context "layout, without words" do
      before(:each){ visit words_path }

      it "has a title" do
        page.should have_title('Words')
      end

      it "has a div for words" do
        page.should have_div('words')
      end
    end #layout, without words

    context "layout, with one word, one definition" do
      before(:each) do
        create_word("cat","is an animal")
        visit words_path
      end

      it "has a div surrounding it" do
        divs_no('word').should be(1)
      end

      it "the word is a link" do
        div('word',0).should have_link('cat')
      end

      it "the word is diplayed in the div" do
        div('word',0).div('word').should have_content('cat')
      end

      it "has one definition div" do
        div('word',0).divs_no('definition').should be(1)
      end

      it "the definition is diplayed in the div" do
        div('word',0).div('definition',0).should have_content('1. is an animal')
      end
    end #layout, with one word, one definition 

    context "layout, with one word, two definitions" do
      before(:each) do
        create_word("cat","is an animal","has a tail")
        visit words_path
      end

      it "has a div surrounding it" do
        divs_no('word').should be(1)
      end

      it "the word is diplayed in the div" do
        div('word',0).div('word').should have_content('cat')
      end

      it "has one definition div" do
        div('word',0).divs_no('definition').should be(2)
      end

      it "the definitions is diplayed in the div" do
        div('word',0).div('definition',0).should have_content('1. is an animal')
        div('word',0).div('definition',1).should have_content('2. has a tail')
      end
    end #layout, with one word, two definitions

    context "layout, with one word, one definition, one form" do
      before(:each) do
        create_word("cat",["is an animal"],["kitten"])
        visit words_path
      end

      it "has a div surrounding it" do
        divs_no('word').should be(1)
      end

      it "has one definition div" do
        div('word',0).divs_no('definition').should be(1)
      end

      it "the definition is diplayed in the div" do
        div('word',0).div('definition',0).should have_content('1. is an animal')
      end

      it "has one form div" do
        div('word',0).divs_no('form').should be(1)
      end

      it "the form is diplayed in the div" do
        div('word',0).div('form',0).should have_content('kitten')
      end
    end #layout, with one word, one definition, one form
  end
end
