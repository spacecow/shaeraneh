class LocalesController < ApplicationController
  authorize_resource

  def index
    @locales = Locale.where('name like ?',"%#{params[:q]}%")
  end
end
