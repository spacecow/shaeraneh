class UsersController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def new
  end

  def create
    if @user.save
      session_userid(@user.id)
      flash[:notice] = notify(:signed_up_and_logged_in)
      if session_original_url
        url = session_original_url
        session_original_url(nil)
        redirect_to url and return
      end
      redirect_to root_url
    else
      render :new
    end 
  end
end
