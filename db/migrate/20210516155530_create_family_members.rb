# frozen_string_literal: true

# Migration to crete the family members table
class CreateFamilyMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :family_members do |t|
      t.references :family, null: false, foreign_key: true
      t.string :is_active, null: false
      t.string :is_head_of_family, null: false
      t.timestamps
    end
  end
end
