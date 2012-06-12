require 'spec_helper'

describe 'Poems, new:' do
  context 'create poem and link to words' do
    before(:each) do
      login_admin
      visit new_poem_path
      fill_in 'Content', with:'a cat on the roof\t\ta dog on the field'
    end

    it "adds a lookup to the database" do
      lambda{ click_button 'Create Poem'
      }.should change(Lookup,:count).by(1)
    end 
  end
end
