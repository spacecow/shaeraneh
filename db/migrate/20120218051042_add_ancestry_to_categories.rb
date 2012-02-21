class AddAncestryToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :ancestry, :string
    add_index :categories, :ancestry
    add_column :categories, :names_depth_cache_ir, :string
    rename_column :categories, :name, :name_ir
  end
end
