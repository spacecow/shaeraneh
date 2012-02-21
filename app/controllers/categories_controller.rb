class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def index 
    @category = params[:id] ? Category.find(params[:id]) : Category.new
  end

  def create
    if @category.save
      redirect_to categories_path, :notice => created(:category)
    else
      @categories = Category.scoped
      render :index
    end
  end

  def update
    if @category.update_attributes(params[:category])
      @category.descendants.map(&:save)
      redirect_to categories_path, :notice => updated(:category)
    else
      @categories = Category.scoped
      render :index
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, :notice => deleted(:category)
  end
end
