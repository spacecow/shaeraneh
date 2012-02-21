class AddSourceIdToDefinitions < ActiveRecord::Migration
  def change
    add_column :definitions, :source_id, :integer
  end
end
