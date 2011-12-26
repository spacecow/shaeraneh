class PoemsController < ApplicationController
  def show
    @poem = Poem.find(params[:id])
  end

  def index
    poems = Poem.order(:first_verse) || []
    @poemgroups = poems.group_by{|e| e.first_verse[0]}
  end

  def new
    @poem = Poem.new
  end

  def create
    @poem = Poem.new(params[:poem])
    if params[:poem][:content].empty?
      @poem.errors.add(:content,"can't be blank")
      render :new and return 
    end
    if @poem.save
      if @poem.verses.count == 1
        flash[:notice] = notify_with(:poem,1,t(:verse))
      else
        flash[:notice] = notify_with(:poem,@poem.verses.count,pt(:verse))
      end
      redirect_to poems_path
    else
      render :new
    end
  end
end
