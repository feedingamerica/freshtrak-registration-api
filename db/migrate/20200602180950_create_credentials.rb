# frozen_string_literal: true

# Create Credentials table
class CreateCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :credentials do |t|
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.string :token, null: false
      t.string :secret, null: true
      t.boolean :expires, null: true
      t.datetime :expires_at, null: true
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
