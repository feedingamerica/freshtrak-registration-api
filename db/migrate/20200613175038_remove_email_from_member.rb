# frozen_string_literal: true

# Remove email column from Household Member
class RemoveEmailFromMember < ActiveRecord::Migration[6.0]
  def change
    remove_column :household_members, :email, :string
  end
end
