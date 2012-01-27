ActiveRecord::Schema.define(:version => 20120104013002) do

  create_table "letters", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poems", :force => true do |t|
    t.string   "first_verse", :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "initial"
  end

  create_table "verses", :force => true do |t|
    t.integer  "poem_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pos"
  end

end
