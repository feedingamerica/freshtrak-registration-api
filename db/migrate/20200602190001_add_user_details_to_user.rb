# frozen_string_literal: true

# Add User Details FK To User
class AddUserDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_detail_id, :bigint
    add_foreign_key :users, :user_details
  end
end
