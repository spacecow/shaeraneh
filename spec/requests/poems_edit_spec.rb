require 'spec_helper'

describe "Poems" do
  describe "edit" do
    before(:each) do
      poem = create_poem('alpha')
      visit edit_poem_path(poem)
    end

    it "layout" do
      page.should have_title('Edit Poem')
      textfield(0).value.should eq 'alpha'
      page.should have_button('Update Poem')
    end

    context "update poem" do
      before(:each) do
        fill_in textfield_id(0), :with => 'beta'
      end

      it "doesnt change the poem&verse count" do
        lambda do
          lambda do
            click_button 'Update Poem'
          end.should change(Verse,:count).by(0)
        end.should change(Poem,:count).by(0)
      end

      it "changes the verse content" do
        click_button 'Update Poem'
        Poem.last.verses.last.content.should eq 'beta' 
      end

      it "redirects to the poem index page" do
        click_button 'Update Poem'
        page.current_path.should eq poems_path
      end

      it "displays a flash message" do
        click_button 'Update Poem'
        page.should have_notice('Successfully updated Poem.')
      end
    end
  end
end
