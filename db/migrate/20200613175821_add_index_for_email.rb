# frozen_string_literal: true

# Add unique index to email on Emails table
class AddIndexForEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :emails, :email, unique: true
  end
end
