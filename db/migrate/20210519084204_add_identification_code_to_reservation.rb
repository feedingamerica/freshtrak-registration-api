# frozen_string_literal: true

# Migration to add identification field to reservations table.
class AddIdentificationCodeToReservation < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :license_plate, :string
    add_column :reservations, :identification_code, :integer, null: false
    add_index :reservations, :identification_code, unique: true
  end
end
