class Word < ActiveRecord::Base
  has_many :definitions
  accepts_nested_attributes_for :definitions

  attr_accessible :name,:definitions_attributes

  validates :name, :presence => true
end
