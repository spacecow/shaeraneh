require 'spec_helper'

describe "Words" do
  describe "edit" do
    context "errors" do
      before(:each) do
        create_admin(:email=>'admin@example.com')
        login('admin@example.com')
        word = create_word("cat")
        visit edit_word_path(word)
      end

      it "word must be unique" do
        create_word("dog")
        fill_in 'Word', with:'dog'
        click_button 'Update Word'
        li(:word).should have_duplication_error
      end
    end
  end
end
