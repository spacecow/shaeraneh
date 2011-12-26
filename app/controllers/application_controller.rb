class ApplicationController < ActionController::Base
  include BasicApplicationController
  helper_method :pt

  protect_from_forgery

  def notify_with(mdl,no,children)
    t("successes.created_with",:o=>t(mdl),:no=>no,:o2=>children)
  end
end
