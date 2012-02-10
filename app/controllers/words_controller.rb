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
end
