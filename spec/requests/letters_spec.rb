require 'spec_helper'

describe "Letters" do
  describe "index" do
    it "layout" do
      visit letters_path
      page.should have_title("Letters")
    end
  end
end
