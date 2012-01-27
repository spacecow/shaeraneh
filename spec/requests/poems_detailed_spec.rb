require 'spec_helper'

describe "Poems" do
  describe "detailed" do
    it "layout" do
      visit detailed_poems_path
    end

    context "list" do
      before(:each) do
        poem = Factory(:poem)
        poem.verses << create_verse('alphatomic')
        poem.verses << create_verse('beta')
      end
    
      it "a div holding all the poems should exist" do
        visit detailed_poems_path
        page.should have_div('poems')
      end

      context "one poem" do
        before(:each) do
          visit detailed_poems_path
        end

        it "a 'c' div should exist" do
          div('poems').should have_div('c')
        end

        it "one poem div should exist" do
          divs_no('poem').should be(1)
        end

        it "the one poem div should have verses" do
          div('poem',0).divs_no('verse').should be(2)
        end

        it "the verses should have content" do
          div('poem',0).divs_text('verse').should eq 'alphatomic, beta'
        end

        it "an edit link is present" do
          div('poem',0).should have_link('Edit')
        end
      end

      context "two poems, alphabetically" do
        before(:each) do
          poem = Factory(:poem)
          poem.verses << create_verse('alpha')
          visit detailed_poems_path
        end

        it "a 'a' div should exist" do
          div('poems').should have_div('a')
        end

        it "'a' div should have a subtitle" do
          div('a').should have_subtitle('a')
        end

        it "two poem divs should exist" do
          divs_no('poem').should be(2)
        end

        it "the poem div should have verses" do
          div('poem',0).divs_no('verse').should be(1)
        end

        it "the verses should have content" do
          div('poem',0).divs_text('verse').should eq 'alpha'
        end
      end
    end #list

    context "link to" do
      it "edit" do
        poem = Factory(:poem)
        poem.verses << create_verse('alpha')
        visit detailed_poems_path
        div('poem',0).click_link 'Edit'
        current_path.should eq edit_poem_path(poem) 
      end
    end #link to
  end #detailed
end
