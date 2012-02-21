class Source < ActiveRecord::Base
  has_many :definitions
  has_many :words, :through => :definitions

  validates :name, presence:true, uniqueness:true

  attr_accessible :name
end
