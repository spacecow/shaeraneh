describe "Poems, index:" do
  context "without poems, admin links to" do
    before(:each) do
      login_admin
      visit poems_path 
    end

    it "new poem, on the top of the page" do
      top_links.click_link "New Poem"
      page.current_path.should eq new_poem_path
    end
    it "new poem, on the bottom of the page" do
      bottom_links.click_link "New Poem"
      page.current_path.should eq new_poem_path
    end
  end

  context "with poems, member links to" do
    before(:each) do
      @poem = create_poem('alpha')
      visit poems_path 
    end

    it "show poem" do
      click_link "alpha"
      page.current_path.should eq poem_path(@poem)
    end
  end

  context "with poems, admin links to" do
    before(:each) do
      login_admin
      @poem = create_poem('alpha')
      visit poems_path 
    end

    it "edit poem" do
      click_link "Edit"
      page.current_path.should eq edit_poem_path(@poem)
    end

    context "delete poem" do
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
end
