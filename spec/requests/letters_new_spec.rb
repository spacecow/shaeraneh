require 'spec_helper'

describe "Letters" do
  describe "new" do
    it "layout" do
      visit new_letter_path
      page.should have_title("New Letter")
    end
  end
end
