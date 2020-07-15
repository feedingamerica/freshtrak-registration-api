# frozen_string_literal: true

# Create User Details table
class CreateUserDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :user_details do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, null: false
      t.string :email, null: true
      t.string :first_name, null: true
      t.string :last_name, null: true
      t.string :location, null: true
      t.string :description, null: true
      t.string :image, null: true
      t.string :phone, null: true
      t.string :urls, null: true
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
