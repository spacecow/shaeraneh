class CreatePoems < ActiveRecord::Migration
  def change
    create_table :poems do |t|
      t.string :first_verse, :default => ""

      t.timestamps
    end
  end
end
