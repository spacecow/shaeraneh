require 'spec_helper'

describe "Poems" do
  describe "new" do
    it "layout" do
      visit new_poem_path
      page.should have_title("New Poem")
      find_field(:content).value.should eq ""
    end

    context "create poem" do
      before(:each) do
        visit new_poem_path
        fill_in "Content", :with => "alpha\t\tbeta\r\ngamma\t\tdelta"
      end

      it "create verses" do
        lambda do
          lambda do
            click_button "Create Poem"
          end.should change(Verse,:count).by(4)
        end.should change(Poem,:count).by(1)
      end

      it "verses belongs to the created poem" do
        click_button "Create Poem"
        poem = Poem.last
        Verse.all.map(&:poem_id).should eq [poem.id, poem.id, poem.id, poem.id]
      end

      it "verses get a content" do
        click_button "Create Poem"
        poem = Poem.last
        Verse.all.map(&:content).should eq %w(alpha beta gamma delta)
      end

      it "poem gets first_verse set" do
        click_button "Create Poem"
        Poem.last.first_verse.should eq "alpha"
      end

      it "flash gets set" do
        click_button "Create Poem"
        page.should have_notice("Successfully created Poem with 4 Verses.")
      end

      it "content can't be blank" do
        lambda do
          fill_in :content, :with => ""
          click_button "Create Poem"
        end.should change(Poem,:count).by(0)
        li(:content).should have_blank_error
      end
    end
  end
end
