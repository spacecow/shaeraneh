require 'spec_helper'

describe "Letters" do
  describe "index" do
    it "layout" do
      visit letters_path
      page.should have_title("Letters")
    end

    it "list letters" do
      Factory(:letter,:name=>'a')
      visit letters_path
      tablemap.should eq [["a"]]
    end

    context "sort on column" do
      before(:each) do
        Factory(:letter,:name=>'b')
        Factory(:letter,:name=>'a')
        visit letters_path
      end

      it "name ascending (default)" do
        tablecell(0,0).should eq 'a'
        tablecell(1,0).should eq 'b'
      end

      it "name descending" do
        click_link 'Name'
        tablecell(0,0).should eq 'b'
        tablecell(1,0).should eq 'a'
      end
    end
  end
end
