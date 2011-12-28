require 'spec_helper'

describe VersesController do
  before(:each) do
    @poem = Factory(:poem)
    @alpha = create_verse('alpha',0)
    @poem.verses << @alpha
    @beta = create_verse('beta',1)
    @poem.verses << @beta
    request.env["HTTP_REFERER"] = poems_path
  end
    
  context "change pos" do
    it "descend verse" do
      send('put','descend',:poem_id=>@poem.id,:id=>@beta.id)
    end
    it "ascend verse" do
      send('put','ascend',:poem_id=>@poem.id,:id=>@alpha.id)
    end
    
    after(:each) do
      @poem.verses.order(:pos).map(&:content).should eq %w(beta alpha)
    end
  end

  context "try to change pos" do
    it "can't descend the first verse" do
      send('put','descend',:poem_id=>@poem.id,:id=>@alpha.id)
    end
    it "can't ascend the last verse" do
      send('put','ascend',:poem_id=>@poem.id,:id=>@beta.id)
    end

    after(:each) do
      @poem.verses.order(:pos).map(&:content).should eq %w(alpha beta)
    end
  end
end
