# -*- coding: utf-8 -*-
class Poem < ActiveRecord::Base
  include PosModel

  has_many :verses, :after_add => :add_first_verse_content, :after_remove => :remove_first_verse_content, :dependent => :destroy
  accepts_nested_attributes_for :verses
  attr_accessible :content,:verses_attributes
  attr_accessor :content
  
  def content=(s)
    s.split("\r\n").map{|e| e.split("\t\t")}.flatten.each_with_index do |verse,i|
      verses << Verse.create!(:content=>verse.strip,:pos=>i)
    end
  end

  def last_letter
    return "" if first_verse.blank?
    i = -1
    while ["!","؟"," ",":","»"].include?(first_verse[i])
      i -= 1
    end
    first_verse[i]
  end

  private

    def add_first_verse_content(verse)
      if first_verse.blank?
        set_first_verse_content(verse.content)
        set_initial
      end
    end

    def children; verses end

    def set_first_verse_content(s)
      update_attribute(:first_verse,s) 
    end
    def set_initial
      update_attribute(:initial,last_letter)
    end

    def remove_first_verse_content(verse)
      if verses.empty?
        set_first_verse_content("")
        set_initial
      else
        if verses.first != first_verse
          set_first_verse_content(verses.first.content) 
          set_initial
        end
      end
    end
end
