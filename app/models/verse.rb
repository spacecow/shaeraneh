class Verse < ActiveRecord::Base
  belongs_to :poem

  has_many :lookups
  has_many :words, :through => :lookups

  attr_accessible :content, :pos
  
  validates_presence_of :pos
  validates_uniqueness_of :pos, :scope => :poem_id 

  searchable do
    text :content
  end

  class << self
    def lookup(s)
      search{ fulltext s }
    end
  end
end
