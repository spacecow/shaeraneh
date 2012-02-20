class Definition < ActiveRecord::Base
  belongs_to :word
  belongs_to :source

  attr_accessor :source_token, :hide

  def source_attributes
    [source.attributes].to_json if source
  end

  def source_token=(s)
    if s =~ /^\d+$/
      self.source = Source.find(s.to_i) if Source.exists?(s.to_i)
    else
      self.source = Source.find_or_create_by_name(s)
    end 
  end
end
