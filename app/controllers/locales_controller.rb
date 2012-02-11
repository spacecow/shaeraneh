class LocalesController < ApplicationController
  def index
    @locales = Locale.where('name like ?',"%#{params[:q]}%")
    respond_to do |f|
      f.json {render :json => @locales.map(&:attributes)}
    end
  end
end
