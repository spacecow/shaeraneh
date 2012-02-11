class WordsController < ApplicationController
  def index
    @words = Word.scoped
    respond_to do |f|
      f.html
      f.json {render :json => []}
    end
  end

  def new
    @word = Word.new
    2.times{@word.definitions.build}
    @last_word = Word.last
  end
  
  def create
    @word = Word.new(params[:word])
    if @word.save
      create_links(@word)
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
  
  private

    def create_links(word)
      arr = word.forms.map(&:name)
      arr << word.name
      arr.each do |s|
        search = Verse.lookup(s)
        word.verses << search.results
      end
    end
end
