# frozen_string_literal: true

# Create Phone Numbers table
class CreatePhoneNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :phone_numbers do |t|
      t.references :location_type, foreign_key: true, null: false
      t.references :carrier_type, foreign_key: true, null: true
      t.references :member, foreign_key: true, null: false
      t.string :phone_number, null: false
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
