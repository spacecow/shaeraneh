# -*- coding: utf-8 -*-
class Poem < ActiveRecord::Base
  has_many :verses, :after_add => :add_first_verse_content, :after_remove => :remove_first_verse_content, :dependent => :destroy
  accepts_nested_attributes_for :verses
  attr_accessible :content,:verses_attributes
  attr_accessor :content
  
  def content=(s)
    s.split("\r\n").map{|e| e.split("\t\t")}.flatten.each do |verse|
      verses << Verse.create!(:content=>verse.strip)
    end
  end

  def last_letter
    i = -1
    while ["!","؟"," "].include?(first_verse[i])
      i -= 1
    end
    first_verse[i]
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
