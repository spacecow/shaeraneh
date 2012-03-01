class SourcesController < ApplicationController
  before_filter :load_sources, :only => :index
  load_and_authorize_resource

  def show
  end

  def index
    @source = params[:id] ? Source.find(params[:id]) : Source.new
  end

  def create
    if @source.save
      redirect_to sources_url, :notice => created(:source)
    else
      render :index
    end
  end

  def update
    if @source.update_attributes(params[:source])
      redirect_to sources_url, :notice => updated(:source)
    else
      render :index
    end
  end

  private

    def load_sources
      @sources = Source.where('name like ?',"%#{params[:q]}%").order(&:name)
    end
end
