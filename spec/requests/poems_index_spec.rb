# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Poems" do
  describe "index" do
    context "general layout" do
      before(:each) do
        visit poems_path
      end

      it "has a title" do
        page.should have_title("Poems")
      end

      it "has no link to a new poem" do
        page.should_not have_link("New Poem")
      end
    end

    context "admin layout" do
      before(:each) do
        create_admin(:email=>'admin@example.com')
        login('admin@example.com')
      end

      it "has a bottom link to a new poem" do
        bottom_links.should have_link("New Poem")
      end

      it "has a top link to a new poem" do
        top_links.should have_link("New Poem")
      end
    end

    context "admin links" do
      before(:each) do
        create_admin(:email=>'admin@example.com')
        login('admin@example.com')
      end

      it "new poem" do
        visit poems_path
        click_link "New Poem"
        page.current_path.should eq new_poem_path
      end

      it "edit poem" do
        poem = create_poem('alpha')
        visit poems_path
        click_link "Edit"
        page.current_path.should eq edit_poem_path(poem)
      end
    end

    context "link to" do
      it "show poem" do
        poem = create_poem("alpha")
        visit poems_path
        click_link "alpha"
        page.current_path.should eq poem_path(poem)
      end

      context "delete poem" do
        before(:each) do
          create_admin(:email=>'admin@example.com')
          login('admin@example.com')
          poem = Factory(:poem)
          poem.verses << create_verse("alpha")
          visit poems_path
        end

        it "reduces the poem count" do
          lambda do
            click_link "Del" 
          end.should change(Poem,:count).by(-1)
        end
      
        it "takes you back to the poem index" do
          click_link "Del"
          page.current_path.should eq poems_path
        end

        it "deletes the verses too" do
          lambda do
            click_link "Del" 
          end.should change(Verse,:count).by(-1)
        end

        it "shows a flash message" do
          click_link "Del"
          page.should have_notice("Poem was successfully deleted.")
        end
      end
    end

    context "list poems" do
      before(:each) do
        poem = Factory(:poem)
        poem.verses << create_verse('betad')
      end

      it "show in a table" do
        visit poems_path
        tableheader.should eq ['d']
        tablecell(0,0).should eq 'betad'
      end

      it "poems are sorted alphabetically" do
        poem2 = Factory(:poem)
        poem2.verses << create_verse('alphac')
        visit poems_path
        tablemaps.first.should eq [['alphac','Edit Del']]
        tablemaps.last.should eq [['betad','Edit Del']]
      end

      it "poems starting with the same letter are grouped toghether" do
        poem2 = Factory(:poem)
        poem2.verses << create_verse('bobyd')
        visit poems_path
        tablemap.should eq [['betad','Edit Del'],['bobyd','Edit Del']]
      end
    end

    context "poems cannot end with" do
      before(:each) do
        @poem = Factory(:poem)
      end
   
      it "!" do 
        @poem.verses << create_verse("alpha!") 
      end

      it "؟" do
        @poem.verses << create_verse("alpha؟") 
      end

      it "\\s" do
        @poem.verses << create_verse("alpha ") 
      end

      after(:each) do
        visit poems_path
        tableheader.should eq ['a']
      end
    end
  end
end
