require 'spec_helper'

describe VersesController do
  describe "positioning" do
    before(:each) do
      @poem = Factory(:poem)
      @alpha = create_verse('alpha',0)
      @poem.verses << @alpha
      @beta = create_verse('beta',1)
      @poem.verses << @beta
      request.env["HTTP_REFERER"] = poems_path
      session[:userid] = create_admin.id
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
  end #positioning

  describe "action authentication" do
    controller_actions = controller_actions("verses")

    before(:each) do
      @parent = Factory(:poem)
      @model  = create_verse('alpha',0)
      @parent.verses << @model
      request.env["HTTP_REFERER"] = poems_path
    end

    describe "a user is not logged in" do
      controller_actions.each do |action,req|
        if %w().include?(action)
          it "should reach the #{action} page" do
            send(req, action, poem_id:@parent.id, id:@model.id)
            response.redirect_url.should_not eq login_url
          end
        else
          it "should not reach the #{action} page" do
            send(req, action, poem_id:@parent.id, id:@model.id)
            response.redirect_url.should eq login_url 
          end
        end
      end
    end

    describe "a user is logged in as" do
      context "member" do
        before(:each) do
          session[:userid] = create_member.id
        end 

        controller_actions.each do |action,req|
          if %w().include?(action)
            it "should reach the #{action} page" do
              send(req, action, poem_id:@parent.id, id:@model.id)
              response.redirect_url.should_not eq welcome_url
            end
          else
            it "should not reach the #{action} page" do
              send(req, action, poem_id:@parent.id, id:@model.id)
              response.redirect_url.should eq welcome_url 
            end
          end
        end
      end #member

      context "vip" do
        before(:each) do
          session[:userid] = create_vip.id
        end 

        controller_actions.each do |action,req|
          if %w().include?(action)
            it "should reach the #{action} page" do
              send(req, action, poem_id:@parent.id, id:@model.id)
              response.redirect_url.should_not eq welcome_url
            end
          else
            it "should not reach the #{action} page" do
              send(req, action, poem_id:@parent.id, id:@model.id)
              response.redirect_url.should eq welcome_url 
            end
          end
        end
      end #vip

      context "miniadmin" do
        before(:each) do
          session[:userid] = create_miniadmin.id
        end 

        controller_actions.each do |action,req|
          if %w().include?(action)
            it "should reach the #{action} page" do
              send(req, action, poem_id:@parent.id, id:@model.id)
              response.redirect_url.should_not eq welcome_url
            end
          else
            it "should not reach the #{action} page" do
              send(req, action, poem_id:@parent.id, id:@model.id)
              response.redirect_url.should eq welcome_url 
            end
          end
        end
      end #vip

      context "admin" do
        before(:each) do
          session[:userid] = create_admin.id
        end 

        controller_actions.each do |action,req|
          if %w(ascend descend).include?(action)
            it "should reach the #{action} page" do
              send(req, action, poem_id:@parent.id, id:@model.id)
              response.redirect_url.should_not eq welcome_url
            end
          else
            it "should not reach the #{action} page" do
              send(req, action, poem_id:@parent.id, id:@model.id)
              response.redirect_url.should eq welcome_url 
            end
          end
        end
      end #vip

      context "god" do
        before(:each) do
          session[:userid] = create_god.id
        end 

        controller_actions.each do |action,req|
          if %w(ascend descend).include?(action)
            it "should reach the #{action} page" do
              send(req, action, poem_id:@parent.id, id:@model.id)
              response.redirect_url.should_not eq welcome_url
            end
          else
            it "should not reach the #{action} page" do
              send(req, action, poem_id:@parent.id, id:@model.id)
              response.redirect_url.should eq welcome_url 
            end
          end
        end
      end #vip
    end #a user is logged in as
  end
end
