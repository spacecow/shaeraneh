class CreateVerses < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.integer :poem_id
      t.string :content

      t.timestamps
    end
  end
end
