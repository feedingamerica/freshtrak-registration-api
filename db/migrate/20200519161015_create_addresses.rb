# frozen_string_literal: true

# Migration to create the addresses table
class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :household_addresses do |t|
      t.belongs_to :household, index: { unique: true }, foreign_key: true
      t.string  :line_1, null: false
      t.string  :line_2
      t.string  :city, null: false
      t.string  :state, null: false
      t.string  :zip_code, null: false
      t.string  :zip_4
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.integer :deleted_by, null: true
      t.datetime :deleted_on, null: true
      t.timestamps
    end
  end
end
