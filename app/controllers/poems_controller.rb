class PoemsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:index,:detailed]
  

  def show
    @verses = @poem.verses.order(:pos)
  end

  def index
    poems = Poem.order(:first_verse) || []
    @poemgroups = poems.group_by{|e| e.initial}
    respond_to do |f|
      f.html
      f.json {render :json => poems.to_json(:include => :verses)}
    end
  end

  def new
    @last_verses = Poem.last ? Poem.last.verses : []
  end

  def create
    if params[:poem] && params[:poem][:content].empty?
      @poem.errors.add(:content,"can't be blank")
      @last_verses = Poem.last ? Poem.last.verses : []
      render :new and return 
    end
    if @poem.save
      if @poem.verses.count == 1
        flash[:notice] = notify_with(:poem,1,pl(:verse,1))
      else
        flash[:notice] = notify_with(:poem,@poem.verses.count,pl(:verse,@poem.verses.count))
      end
      redirect_to new_poem_path
    else
      @last_verses = Poem.last ? Poem.last.verses : []
      render :new
    end
  end

  def edit
  end

  def update
    if @poem.update_attributes(params[:poem])
      redirect_to detailed_poems_path, :notice => updated(:poem)
    end
  end

  def destroy
    @poem.destroy
    redirect_to poems_path, :notice => deleted(:poem)
  end

  def detailed
    poems = Poem.order(:first_verse)
    @poemgroups = poems.group_by{|e| e.initial}
  end
end
