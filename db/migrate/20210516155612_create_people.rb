# frozen_string_literal: true

# Migration to crete the people table
class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.references :user, foreign_key: true, null: false
      t.references :family_member, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :middle_name, null: true
      t.string :last_name, null: true
      t.string :suffix, null: true
      t.string :gender, null: true
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
