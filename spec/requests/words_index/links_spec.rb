require 'spec_helper'

describe "Words" do
  describe "index" do
    context "links, with words" do
      before(:each) do
        @cat = create_word('cat')
        create_admin(:email=>'admin@example.com')
        login('admin@example.com')
        visit words_path
      end

      it "link to the show page" do
        div('word',0).click_link 'cat'
        current_path.should eq word_path(@cat)
      end

      it "link to the edit page" do
        div('word',0).click_link 'Edit'
        current_path.should eq edit_word_path(@cat)
      end
    end
  end
end
