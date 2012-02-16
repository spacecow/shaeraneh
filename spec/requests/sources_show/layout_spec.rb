require 'spec_helper'

describe "Sources" do
  context "show, layout" do
    before(:each) do
      @ne = Factory(:source,name:'NE')
      visit source_path(@ne)
    end

    it "has a title" do
      page.should have_title(@ne.name)
    end
  end
end
