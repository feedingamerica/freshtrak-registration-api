# frozen_string_literal: true

# Add unique index to member email
class AddIndexToMemberEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :household_members, :email, unique: true
  end
end
