class VersesController < ApplicationController
  include PosController
  load_and_authorize_resource

  private

    def child; @poem.verses.find(params[:id]) end
    def parent; @poem = Poem.find(params[:poem_id]) end
    def pos_function; :update_first_verse end
    def update_first_verse(child,new_child)
      upper_child = [child,new_child].select{|e| e.pos!=0}.first
      @poem.update_attribute(:first_verse,upper_child.content) if [child.pos,new_child.pos].min == 0
    end
end
