class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email],params[:password])
    if user
      redirect_to 
    else
      flash.now.alert = alertify(:invalid_login_or_password)
      render :new
    end
  end
end
