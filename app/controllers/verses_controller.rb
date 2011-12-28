class VersesController < ApplicationController
  include PosController

  private

    def child; @poem.verses.find(params[:id]) end
    def parent; @poem = Poem.find(params[:poem_id]) end
end
