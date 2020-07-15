# frozen_string_literal: true

# Add Credentials FK to Users
class AddCredentialsForeignKeyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :credential_id, :bigint
    add_foreign_key :users, :credentials
  end
end
