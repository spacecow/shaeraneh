class Categorization < ActiveRecord::Base
  belongs_to :word
  belongs_to :category

  class << self
    def first_owner; first.word end
    def last_owner; last.word end
  end
end
