# frozen_string_literal: true

# Migration to create the phones table
class CreatePhones < ActiveRecord::Migration[6.1]
  def change
    create_table :phones do |t|
      t.references :person, foreign_key: true, null: false
      t.string  :phone, null: false
      t.string  :permission_to_text, null: false
      t.timestamps
    end
  end
end
