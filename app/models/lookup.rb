class Lookup < ActiveRecord::Base
  belongs_to :word
  belongs_to :verse

  def verse_content; verse.content end
end
