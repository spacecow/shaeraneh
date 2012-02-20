require 'spec_helper'

describe "Words" do
  before(:each) do
    create_admin(:email=>'admin@example.com')
    login('admin@example.com')
  end

  context "new, create category" do
    before(:each) do
      visit new_word_path
      fill_in 'Word', :with => 'dog'
    end
    
    it "adds a word to the database" do
      lambda do
        click_button 'Create Word'
      end.should change(Word,:count).by(1)
    end

    it "adds no definition to the databse" do
      lambda do
        click_button 'Create Word'
      end.should change(Definition,:count).by(0)
    end

    it "adds no source to the databse" do
      lambda do
        click_button 'Create Word'
      end.should change(Source,:count).by(0)
    end

    context "no category" do
      it "adds no category to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Category,:count).by(0)
      end
      it "adds no categorization to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Categorization,:count).by(0)
      end
    end

    context "with existing category" do
      before(:each) do
        category = create_category('poem')
        fill_in 'Category', with:category.id 
      end

      it "adds no category to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Category,:count).by(0)
      end
      it "adds a categorization to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Categorization,:count).by(1)
      end

      it "connects the category to the word" do
        click_button 'Create Word'
        Categorization.last.word = Word.last
        Categorization.last.category = Category.last
      end
    end

    context "with existing categories" do
      before(:each) do
        poem = create_category('poem')
        novel = create_category('novel')
        fill_in 'Category', with:"#{poem.id}, #{novel.id}" 
      end

      it "adds no categories to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Category,:count).by(0)
      end
      it "adds categorizations to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Categorization,:count).by(2)
      end

      it "connects the categories to the word" do
        click_button 'Create Word'
        Categorization.first.word = Word.first
        Categorization.first.category = Category.first
        Categorization.last.word = Word.last
        Categorization.last.category = Category.last
      end
    end

    context "with new category" do
      before(:each) do
        fill_in 'Category', with:"NE" 
      end

      it "adds a category to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Category,:count).by(1)
      end
      it "adds a categorization to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Categorization,:count).by(1)
      end

      it "connects the category to the word" do
        click_button 'Create Word'
        Categorization.last.word = Word.last
        Categorization.last.category = Category.last
      end
    end

    context "with new category that already exists" do
      before(:each) do
        create_category('poem')
        fill_in 'Category', with:'poem' 
      end

      it "adds no category to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Category,:count).by(0)
      end
      it "adds a categorization to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Categorization,:count).by(1)
      end

      it "connects the category to the word" do
        click_button 'Create Word'
        Categorization.last.word = Word.last
        Categorization.last.category = Category.last
      end
    end

    context "with new category with digits" do
      before(:each) do
        fill_in 'Category', with:'666' 
      end

      it "adds no category to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Category,:count).by(0)
      end
      it "adds no categorization to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Categorization,:count).by(0)
      end

      it "word categoreis are empty" do
        click_button 'Create Word'
        Word.last.categories.should be_empty 
      end
    end

    context "treed category, with existing categories" do
      before(:each) do
        fill_in 'Category', with:'poem\Limmerick'
      end

      it "adds categories to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Category,:count).by(2)
      end

      it "categories are chained" do
        click_button 'Create Word'
        Category.last.parent.should eq Category.first
        Category.first.children.should eq [Category.last]
      end
    end

    context "treed category, with a new category" do
      before(:each) do
        create_category('poem')
        fill_in 'Category', with:'poem\Limmerick'
      end

      it "adds categories to the database" do
        lambda do
          click_button 'Create Word'
        end.should change(Category,:count).by(1)
      end

      it "categories are chained" do
        click_button 'Create Word'
        Category.last.parent.should eq Category.first
        Category.first.children.should eq [Category.last]
      end

      it "a tree is saved in names_depth_cache" do
        click_button 'Create Word'
        Category.first.names_depth_cache_ir.should eq 'poem'
        Category.last.names_depth_cache_ir.should eq 'poem\Limmerick'
      end
    end
  end
end
