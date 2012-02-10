class Word < ActiveRecord::Base
  has_many :definitions, :dependent => :destroy 
  accepts_nested_attributes_for :definitions, :reject_if => lambda{|e| e[:content].blank? }, allow_destroy:true

  attr_accessible :name,:definitions_attributes

  validates :name, presence:true, uniqueness:true
end
