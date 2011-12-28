class AddPosToVerses < ActiveRecord::Migration
  def change
    add_column :verses, :pos, :integer
  end
end
