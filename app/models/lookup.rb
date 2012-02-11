class Lookup < ActiveRecord::Base
  belongs_to :word
  belongs_to :verse
end
