class CreateLookups < ActiveRecord::Migration
  def change
    create_table :lookups do |t|
      t.integer :verse_id
      t.integer :word_id

      t.timestamps
    end
  end
end
