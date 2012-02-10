class WordsController < ApplicationController
  def index
    @words = Word.scoped
  end

  def new
    @word = Word.new
    @word.definitions.build
    @last_word = Word.last
  end
  
  def create
    @word = Word.new(params[:word])
    if @word.save
      redirect_to new_word_path, :notice => created(:word)
    else
      render :new
    end
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    @word = Word.find(params[:id])
    if @word.update_attributes(params[:word])
      redirect_to words_path
    else
      render :edit
    end
  end
end
