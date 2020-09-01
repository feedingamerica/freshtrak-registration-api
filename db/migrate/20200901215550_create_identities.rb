# frozen_string_literal: true

# Migration to add Identity table.
class CreateIdentities < ActiveRecord::Migration[6.0]
  def change
    create_table :identities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider_uid, null: false
      t.string :provider_type, null: false
      t.string :auth_hash, null: false
      t.timestamps
    end
  end
end
