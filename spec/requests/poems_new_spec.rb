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
        fill_in "Content", :with => "alpha \t\t beta\r\n gamma \t\tdelta"
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

      it "verses get a content without end&beginning whitespace" do
        click_button "Create Poem"
        poem = Poem.last
        Verse.all.map(&:content).should eq %w(alpha beta gamma delta)
      end

      it "redirects back to the new poem page" do
        click_button "Create Poem"
        page.current_path.should eq new_poem_path
      end

      it "poem gets first_verse set" do
        click_button "Create Poem"
        Poem.last.first_verse.should eq "alpha"
      end

      it "poem gets initial set" do
        click_button "Create Poem"
        Poem.last.initial.should eq "a"
      end

      it "last verse set gets shown" do
        click_button "Create Poem"
        page.should have_content('alpha')
        page.should have_content('beta')
        page.should have_content('gamma')
        page.should have_content('delta')
      end

      it "flash gets set" do
        click_button "Create Poem"
        page.should have_notice("Successfully created a Poem with 4 Verses.")
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
