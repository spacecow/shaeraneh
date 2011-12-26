require 'spec_helper'

describe "Poems" do
  describe "show" do
    it "list verses" do
      poem = Factory(:poem)
      poem.verses << create_verse("alpha")
      poem.verses << create_verse("beta")
      visit poem_path(poem)
      p li(0)
    end
  end
end
