require 'spec_helper'

describe "Words" do
  describe "new" do
    before(:each){ visit new_word_path }

    context "layout" do
      it "has a title" do
        page.should have_title('New Word') 
      end
      it "word field should be empty" do
        value('Word').should be_nil
      end
      it "definition field should be empty" do
        value('Definition').should be_empty
      end
      it "there should be only one def. field"  do
        lis(:definition).count.should be(1)
      end
      it "has a create button" do
        page.should have_button('Create Word')
      end
    end
  end
end
