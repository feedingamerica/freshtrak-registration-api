# frozen_string_literal: true

# Migration to create the emails table
class CreateTableEmails < ActiveRecord::Migration[6.1]
  def change
    create_table :table_emails do |t|
      t.references :person, foreign_key: true, null: false
      t.string  :email, null: false
      t.string  :permission_to_email, null: false
      t.timestamps
    end
  end
end
