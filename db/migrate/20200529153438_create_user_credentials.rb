class CreateUserCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :user_credentials do |t|
      t.string :token, null: false
      t.string :secret, null: true
      t.boolean :expires, null: true
      t.datetime :expires_at, null: true
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
    end
  end
end
