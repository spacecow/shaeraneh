class Definition < ActiveRecord::Base
  belongs_to :word

  validates :content, :presence => true
end
