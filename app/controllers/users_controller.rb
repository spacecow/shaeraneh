class UsersController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def new
  end

  def create
    if @user.save
      redirect_to root_url, :notice => notify(:email_with_userinfo_has_been_sent)
      signup_token = SignupToken.create(email:@user.email)
      UserMailer.signup(@user,signup_confirmation_url(signup_token.token)).deliver
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
