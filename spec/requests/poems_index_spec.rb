require 'spec_helper'

describe "Poems" do
  describe "index" do
    it "layout" do
      visit poems_path
      page.should have_title("Poems")
      page.should have_link("New Poem")
    end

    context "link to" do
      it "new poem" do
        visit poems_path
        click_link "New Poem"
        page.current_path.should eq new_poem_path
      end

      it "show poem" do
        poem = Factory(:poem)
        poem.verses << create_verse("alpha")
        visit poems_path
        click_link "alpha"
        page.current_path.should eq poem_path(poem)
      end
    end

    context "list poems" do
      before(:each) do
        poem = Factory(:poem)
        poem.verses << create_verse('beta')
      end

      it "show in a table" do
        visit poems_path
        tablecell(0,0).should eq 'b'
        tablecell(1,0).should eq 'beta'
      end

      it "poems are sorted alphabetically" do
        poem2 = Factory(:poem)
        poem2.verses << create_verse('alpha')
        visit poems_path
        tablemaps.first.should eq [['a'],['alpha']]
        tablemaps.last.should eq [['b'],['beta']]
      end

      it "poems starting with the same letter are grouped toghether" do
        poem2 = Factory(:poem)
        poem2.verses << create_verse('boby')
        visit poems_path
        tablemap.should eq [['b'],['beta'],['boby']]
      end
    end
  end
end
