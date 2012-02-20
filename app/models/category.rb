class Category < ActiveRecord::Base
  has_many :categorizations, :dependent => :destroy
  has_many :words, :through => :categorizations

  attr_accessible :name,:parent_id
  before_save :cache_ancestry

  validates :name, presence:true, uniqueness:true
  has_ancestry :orphan_strategy => :rootify

  class << self
    def token(s,a)
      if s =~ /^\d+$/
        cat = find(s) if exists?(s)
      else
        cat = find_or_create_by_name(s)
      end
      token(a.shift,a).update_attribute(:parent_id,cat) unless a.empty?
      cat 
    end
  end

  private

    def cache_ancestry
      self.names_depth_cache_ir = ancestors.map(&:name).push(name).join('\\')
    end 
end
