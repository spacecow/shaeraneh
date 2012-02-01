require 'spec_helper'

describe "Site" do
  before(:each){ visit root_path }
  context "layout" do
    context "site nav" do
      it "has a link to the poems index" do
        site_nav.should have_link('Poems')
      end
      it "has a link to the words index" do
        site_nav.should have_link('Words')
      end
    end
  end

  context "links to" do
    it "poems index" do
      site_nav.click_link 'Poems'
      current_path.should eq poems_path
    end
    it "words index" do
      site_nav.click_link 'Words'
      current_path.should eq words_path
    end
  end
end
