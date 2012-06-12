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
    end

    context "member layout, with words" do
      before(:each) do
        create_word("cat","is an animal")
        visit words_path
      end

      it "the word is a link" do
        div('word',0).should have_link('cat')
      end

      it "does not have an edit link" do
        div('word',0).should_not have_link('Edit')
      end
    end #layout, without words

    context "admin layout" do
      before(:each) do
        login_admin
        create_word("cat","is an animal")
        visit words_path
      end

      it "does have an edit link" do
        div('word',0).should have_link('Edit')
      end
    end

    context "member layout, with one word linked to a verse", solr:true do
      before(:each) do
        @poem = create_poem('cat on the roof')
        Sunspot.commit
        Factory(:word,name:"cat")
        visit words_path
      end

      it "has a lookups div for lookup" do
        div('word',0).should have_div('lookups')
      end

      it "shows a lookup link to that word", solr:true do
        div('lookups').divs_no('lookup').should be(1)
      end

      it "a lookup displays the verse", focus:true do
        save_and_open_page
        div('lookup',0).should have_content('cat on the roof')
      end

      it "displays the lookup word as a link" do
        div('lookup',0).should have_link('cat')
      end

      it "the lookup word link is a link to that poem" do
        div('lookup',0).click_link 'cat'
        current_path.should eq poem_path(@poem) 
      end
    end

    context "member layout, with one word, one definition" do
      before(:each) do
        create_word("cat","is an animal")
        visit words_path
      end

      it "has a div surrounding it" do
        divs_no('word').should be(1)
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

    context "member layout, with one word, one definition, one source" do
      before(:each) do
        cat = Factory(:word,name:'cat')
        definition = Factory(:definition,content:'is an animal')
        @ne = Factory(:source,name:'NE')
        cat.definitions << definition
        @ne.definitions << definition
        visit words_path
      end

      it "has a div surrounding it" do
        divs_no('word').should be(1)
      end

      it "the word is diplayed in the div" do
        div('word',0).div('word').should have_content('cat')
      end

      it "has one definition div" do
        div('word',0).divs_no('definition').should be(1)
      end

      it "the definition is diplayed in the div" do
        div('word',0).div('definition',0).should have_content('1. is an animal - NE')
      end

      it "the source is a link" do
        div('definition',0).should have_link('NE')
      end

      it "the source is linked to the source show page" do
        div('definition',0).click_link 'NE'
        current_path.should eq source_path(@ne)
      end
    end #layout, with one word, one definition, one source

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
