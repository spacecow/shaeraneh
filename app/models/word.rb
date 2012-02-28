class Word < ActiveRecord::Base
  has_many :definitions, :dependent => :destroy 
  has_many :sources, :through => :definitions

  accepts_nested_attributes_for :definitions, :reject_if => lambda{|e| e[:content].blank? }, allow_destroy:true
  has_many :forms, :dependent => :destroy

  has_many :lookups
  has_many :verses, :through => :lookups

  has_many :categorizations, :dependent => :destroy
  has_many :categories, :through => :categorizations

  attr_reader :form_tokens, :category_tokens
  attr_accessible :name,:definitions_attributes,:form_tokens,:category_tokens

  before_save :set_links

  validates :name, presence:true, uniqueness:true

  def category_tokens=(a)
    tokens = []
    a.split(',').map(&:strip).each do |s|
      tokens.push treed_category_token(s)
    end
    self.category_ids = tokens
  end

  def form_tokens=(s)
    tokens = []
    s.split(',').map(&:strip).each do |f|
      if f =~ /^\d+$/
        tokens.push f 
      else
        tokens.push Form.create!(:name=>f).id 
      end
    end
    self.form_ids = tokens
  end

  def wording
    (["<span id='base'>#{name}</span>"] + forms.map(&:name)).join(', ').html_safe
  end

  private
    
    def set_links
      arr = self.forms.map(&:name)
      arr << self.name
      self.lookups.destroy_all
      self.verses = []
      arr.each do |s|
        search = Verse.lookup(s)
        p Lookup.count
        search.results.each{|verse| self.lookups << Lookup.create(verse_id:verse.id, name:s) }
        p Lookup.count
      end
    end

    def treed_category_token(s)
      a = s.split('\\')
      cat = Category.token(a.shift,a)
      cat.id
    end
end
