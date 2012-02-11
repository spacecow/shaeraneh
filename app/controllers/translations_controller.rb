class TranslationsController < ApplicationController
  def index
    @translations = TRANSLATION_STORE
    @translation = Translation.new
  end

  def create
    @translation = Translation.new(params[:translation])
    if @translation.valid?
      I18n.backend.store_translations(@translation.locale.name, {@translation.key => @translation.value}, escape:false)
      redirect_to translations_path
    else
      @translation.errors.add(:locale_token,@translation.errors[:locale]) if @translation.errors[:locale]
      @translations = TRANSLATION_STORE
      render :index
    end
  end

  def update_multiple
    (params[:en]||{}).each do |k,v|
      I18n.backend.store_translations(v[:locale], {v[:key]=>v[:value]}, :escape => false) unless v[:value].blank?
    end
    (params[:ir]||{}).each do |key,value|
      I18n.backend.store_translations(value[:locale], {value[:key] => value[:value]}, :escape => false) unless value[:value].blank?
    end
    redirect_to translations_path
  end
end
