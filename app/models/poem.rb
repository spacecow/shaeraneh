class Poem < ActiveRecord::Base
  has_many :verses, :after_add => :add_first_verse_content, :after_remove => :remove_first_verse_content

  attr_accessible :content
  attr_accessor :content
  
  def content=(s)
    s.split("\r\n").map{|e| e.split("\t\t")}.flatten.each do |verse|
      verses << Verse.create!(:content=>verse)
    end
  end

  private

    def add_first_verse_content(verse)
      update_attribute(:first_verse,verse.content) if first_verse.blank?
    end

    def remove_first_verse_content(verse)
      if verses.empty?
        update_attribute(:first_verse,"")
      else
        update_attribute(:first_verse,verses.first.content) if verses.first != first_verse
      end
    end
end
