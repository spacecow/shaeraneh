class Category < ActiveRecord::Base
  has_many :categorizations, :dependent => :destroy
  has_many :words, :through => :categorizations

  attr_accessible :name_ir,:parent_id
  before_save :cache_ancestry

  validates :name_ir, presence:true, uniqueness:true
  has_ancestry :orphan_strategy => :rootify

  def name(lang)
    #send "name_#{lang}" 
    name_ir
  end

  class << self
    def first_owner; owner.first end
    def last_owner; owner.last end
    def owner; Word end

    def selected_path(search)
      where('names_depth_cache_ir like ?',"%#{search}%")
    end
    def separate(lang,*cats)
      cats.join('\\')
    end

    def token(s,a)
      if s =~ /^\d+$/
        cat = exists?(s) ? find(s) : create(name_ir:s)
      else
        cat = find_or_create_by_name_ir(s)
      end
      token(a.shift,a).update_attribute(:parent_id,cat) unless a.empty?
      cat 
    end
  end

  private

    def cache_ancestry
      self.names_depth_cache_ir = ancestors.map(&:name_ir).push(name_ir).join('\\')
    end 
end
