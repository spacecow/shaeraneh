class ApplicationController < ActionController::Base
  include BasicApplicationController
  helper_method :pl, :jt

  protect_from_forgery

  def notify_with(mdl,no,children)
    jt("successes.created_with",:o=>pl(mdl,1),:no=>no,:o2=>children)
  end

  def t
    fe
  end
end
