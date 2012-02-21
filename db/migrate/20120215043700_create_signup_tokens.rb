class CreateSignupTokens < ActiveRecord::Migration
  def change
    create_table :signup_tokens do |t|
      t.string :token
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end
end
