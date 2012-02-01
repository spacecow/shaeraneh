class Word < ActiveRecord::Base
  has_many :definitions
  accepts_nested_attributes_for :definitions
end
