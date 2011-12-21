class LettersController < ApplicationController
  def index
    @letters = Letter.all
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
end
