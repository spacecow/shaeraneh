class ApplicationController < ActionController::Base
  include BasicApplicationController
  helper_method :pl, :jt, :current_user, :mess

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = alertify(:unauthorized_access)
    flash[:alert] = exception.message
    if current_user
      redirect_to welcome_url
    else
      session_original_url(request.path)
      redirect_to login_url
    end
  end

  def notify_with(mdl,no,children)
    jt("successes.created_with",:o=>pl(mdl,1),:no=>no,:o2=>children)
  end

end
