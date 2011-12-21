class LettersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @letters = Letter.order(sort_column+" "+sort_direction)
  end

  def new
    @letter = Letter.new
  end

  def create
    @letter = Letter.new(params[:letter])
    if @letter.save
      redirect_to letters_path
    else
      render :new
    end
  end

  private

    def sort_column
      Letter.column_names.include?(params[:sort]) ? params[:sort] : 'name'
    end
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
