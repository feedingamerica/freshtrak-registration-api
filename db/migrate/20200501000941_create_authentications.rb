class CreateAuthentications < ActiveRecord::Migration[6.0]
  def change
    create_table :authentications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end
    add_index :authentications, :token, unique: true
  end
end
