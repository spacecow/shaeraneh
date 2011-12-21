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
  end
end
