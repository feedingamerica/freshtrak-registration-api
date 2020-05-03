# frozen_string_literal: true

# Migration to add data/identification fields to users
class AddIdentificationFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |users|
      users.string :first_name, :middle_name, :last_name, :suffix, :gender,
                   :phone, :email, :address_line_1, :address_line_2, :city,
                   :state, :zip_code, :license_plate
      users.integer :seniors_in_household, :adults_in_household,
                    :children_in_household
      users.boolean :permission_to_email, :permission_to_text
      users.date :date_of_birth
      users.string :identification_code, null: false

      users.index :identification_code, unique: true
    end
  end
end
