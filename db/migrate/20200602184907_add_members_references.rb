# frozen_string_literal: true

# Add Members references to Gender and Suffix
class AddMembersReferences < ActiveRecord::Migration[6.0]
  def change
    change_table :household_members, bulk: true do |t|
      t.column :gender_id, :bigint
      t.column :suffix_id, :bigint
    end
    add_foreign_key :household_members, :genders
    add_foreign_key :household_members, :suffixes
  end
end
