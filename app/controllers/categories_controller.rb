class CategoriesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => :index

  def show
  end

  def index 
    if params[:id]
      @category = Category.find(params[:id])
      @categories = Category.where(["id NOT IN (?)",@category.subtree_ids])
    else
      @category = Category.new
      @categories = Category.scoped
    end
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
      @categories = Category.where(["id NOT IN (?)",@category.subtree_ids])
      render :index
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, :notice => deleted(:category)
  end
end
