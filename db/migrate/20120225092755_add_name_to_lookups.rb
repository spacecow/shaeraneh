class AddNameToLookups < ActiveRecord::Migration
  def change
    add_column :lookups, :name, :string
  end
end
