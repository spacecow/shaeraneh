class Verse < ActiveRecord::Base
  belongs_to :poem

  attr_accessible :content, :pos
  
  validates :pos, :presence => true, :uniqueness => true
end
