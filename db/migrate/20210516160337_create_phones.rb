# frozen_string_literal: true

# Migration to create the phones table
class CreatePhones < ActiveRecord::Migration[6.1]
  def change
    create_table :phones do |t|
      t.references :contact, foreign_key: true, null: false
      t.string :phone, null: false
      t.string :kind
      t.boolean :is_primary
      t.boolean :permission_to_text, null: false, default: false
      t.index :phone, unique: true
      t.timestamps
    end
  end
end
