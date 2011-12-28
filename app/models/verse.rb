class Verse < ActiveRecord::Base
  belongs_to :poem

  attr_accessible :content, :pos
  
  validates_presence_of :pos
  validates_uniqueness_of :pos, :scope => :poem_id 
end
