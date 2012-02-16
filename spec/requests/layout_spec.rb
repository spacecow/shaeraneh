require 'spec_helper'

describe "Site" do
  context "layout" do
    context "member site nav" do
      before(:each){ visit root_path }

      it "has a link to the poems index" do
        site_nav.should have_link('Poems')
      end
      it "has a link to the words index" do
        site_nav.should have_link('Words')
      end
      it "has no link to the translations index" do
        site_nav.should_not have_link('Translations')
      end
      it "has a link to the sources index" do
        site_nav.should have_link('Sources')
      end
    end

    context "member site nav" do
      before(:each) do
        create_admin(:email=>'admin@example.com')
        login('admin@example.com')
        visit root_path
      end

      it "has a link to the translations index" do
        site_nav.should have_link('Translations')
      end
    end
  end

  context "member links to" do
    before(:each){ visit root_path }

    it "poems index" do
      site_nav.click_link 'Poems'
      current_path.should eq poems_path
    end
    it "words index" do
      site_nav.click_link 'Words'
      current_path.should eq words_path
    end
    it "sources index" do
      site_nav.click_link 'Sources'
      current_path.should eq sources_path
    end
  end

  context "admin links to" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      visit root_path
    end

    it "translations index" do
      site_nav.click_link 'Translations'
      current_path.should eq translations_path
    end
  end
end
