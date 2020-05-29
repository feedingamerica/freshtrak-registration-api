# frozen_string_literal: true

# Migration to crete the users table
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :user_type, null: false

      t.timestamps
    end
  end
end
