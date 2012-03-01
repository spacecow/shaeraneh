class WordsController < ApplicationController
  load_and_authorize_resource

  def index
    respond_to do |f|
      f.html
      f.json {render :json => []}
    end
  end

  def new
    @word.definitions.build
    add_definition_field(9)
    @last_word = Word.last
  end
  
  def create
    if @word.save
      redirect_to new_word_path, :notice => created(:word)
    else
      add_definition_field(10-@word.definitions.length)
      render :new
    end
  end

  def edit
    add_definition_field(10-@word.definitions.length)
  end

  def update
    #params[:word][:definitions_attributes].each do |k,v|
    #  params[:word][:definitions_attributes].delete(k) if v[:content].blank?
    #end
    if @word.update_attributes(params[:word])
      redirect_to words_path
    else
      add_definition_field(10-@word.definitions.length)
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

    def add_definition_field(i)
      i.times do
        #definition = Definition.new
        #definition.hide = true
        @word.definitions.build(hide:true) #<< definition
      end
    end

end
