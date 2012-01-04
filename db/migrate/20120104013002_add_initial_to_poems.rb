class AddInitialToPoems < ActiveRecord::Migration
  def self.up
    add_column :poems, :initial, :string

    Poem.reset_column_information
    Poem.all.each do |p|
      p.update_attribute :initial, p.last_letter
    end
  end

  def self.down
    remove_column :poems, :initial
  end
end
