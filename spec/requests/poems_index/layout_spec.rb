describe "Poems, index:" do
  context "member layout without poems" do
    before(:each){ visit poems_path } 

    it "has a title" do
      page.should have_title("Poems")
    end

    it "has no link to a new poem" do
      page.should_not have_link("New Poem")
    end

    it "has no bottom link to a new poem" do
      bottom_links.should_not have_link("New Poem")
    end

    it "has no top link to a new poem" do
      top_links.should_not have_link("New Poem")
    end

    it "has no poems div" do
      page.should_not have_div(:poemgroups)
    end    
  end

  context "member layout with poems" do
    before(:each) do
      create_poem('alpha')
      visit poems_path
    end

    it "has the poems within a div" do
      page.should have_div(:poemgroups)
    end    

    it "has a table for each initial letter" do
      div(:poemgroups).tables_no(:poemgroup).should be(1)
    end

    it "the initial letter is shown in the table header" do
      tableheader.should eq ['a']
    end

    it "the poem is shown in the table" do
      tablecell(0,0).should eq 'alpha'
    end

    it "has no edit link" do
      table(:poemgroup,0).should_not have_link('Edit')
    end

    it "has no delete link" do
      table(:poemgroup,0).should_not have_link('Del')
    end
  end

  context "admin layout without poems" do
    before(:each) do
      login_admin
      visit poems_path
    end

    it "has a bottom link to a new poem" do
      bottom_links.should have_link("New Poem")
    end

    it "has a top link to a new poem" do
      top_links.should have_link("New Poem")
    end
  end

  context "admin layout without poems" do
    before(:each) do
      login_admin
      create_poem('alpha')
      visit poems_path
    end

    it "has an edit link" do
      table(:poemgroup,0).should have_link('Edit')
    end

    it "has a delete link" do
      table(:poemgroup,0).should have_link('Del')
    end
  end
end
