# frozen_string_literal: true

# Migration to create the household_addresses table
class CreateHouseholdAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :household_addresses do |t|
      t.belongs_to :household, index: { unique: true }, foreign_key: true
      t.string  :address_line_1, null: false
      t.string  :address_line_2, null: false
      t.string  :city, null: false
      t.string  :state, null: false
      t.string  :zip_code, null: false
      t.string  :zip_4, null: false
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
