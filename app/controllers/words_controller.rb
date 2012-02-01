class WordsController < ApplicationController
  def index
  end

  def new
    @word = Word.new
    @word.definitions.build
  end
end
