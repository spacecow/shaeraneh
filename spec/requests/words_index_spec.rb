require 'spec_helper'

describe 'Words' do
  describe 'index' do
    context 'general layout' do
      before(:each){ visit words_path }

      it 'has no links to creation of words' do
        page.should_not have_link('New Word')        
      end
    end

    context 'admin layout' do
      before(:each) do
        create_admin(:email=>'admin@example.com')
        login('admin@example.com')
        visit words_path
      end

      context 'top links has links to' do
        it 'creating a new word' do
          top_links.should have_link('New Word')
        end
      end 
      context 'bottom links has links to' do
        it 'creating a new word' do
          bottom_links.should have_link('New Word')
        end
      end 
    end #layout

    context 'admin links to' do
      before(:each) do
        create_admin(:email=>'admin@example.com')
        login('admin@example.com')
        visit words_path
      end

      context 'top links to' do
        it 'creating a new word' do
          top_links.click_link 'New Word'
          current_path.should eq new_word_path
        end 
      end 
      context 'bottom links to' do
        it 'creating a new word' do
          bottom_links.click_link 'New Word'
          current_path.should eq new_word_path
        end 
      end 
    end #links to
  end
end
