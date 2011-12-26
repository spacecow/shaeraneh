require 'spec_helper'

describe "Poems" do
  describe "show" do
    it "list verses" do
      poem = Factory(:poem)
      poem.verses << create_verse("alpha")
      poem.verses << create_verse("beta")
      visit poem_path(poem)
      li(0).should have_content("alpha")
      li(1).should have_content("beta")
    end
  end
end
