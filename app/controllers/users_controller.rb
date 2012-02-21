class UsersController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def new
  end

  def create
    if @user.save
      signup_token = SignupToken.create(email:@user.email)
      session_userid(@user.id)
      #flash[:notice] = notify(:email_with_userinfo_has_been_sent)
      flash[:notice] = notify(:signed_up_and_logged_in)
      #UserMailer.signup(@user,signup_confirmation_url(signup_token.token)).deliver
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

  def signup_confirmation
    token = SignupToken.find_by_token(params[:token])
    if token
      user = User.find_by_email(token.email)
      if user
        flash[:notice] = notify(:account_activated)
        user.signup_token = token
        session_userid(user.id)
        if session_original_url
          url = session_original_url
          session_original_url(nil)
          redirect_to url and return
        end
      else
        flash[:alert] = alertify(:user_does_not_exist)
      end
    else
      flash[:alert] = alertify(:invalid_signup_token)
    end
    redirect_to root_url
  end
end
