class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :key
      t.string :value
      t.integer :locale_id

      t.timestamps
    end
  end
end
