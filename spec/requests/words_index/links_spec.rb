require 'spec_helper'

describe "Words" do
  describe "index" do
    context "links, with words" do
      before(:each) do
        @cat = create_word('cat')
        visit words_path
      end

      it "link to the edit page" do
        div('word',0).click_link 'cat'
        current_path.should eq edit_word_path(@cat)
      end
    end
  end
end
