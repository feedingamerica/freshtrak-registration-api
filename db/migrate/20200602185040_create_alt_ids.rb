# frozen_string_literal: true

# Create Alt Ids table
class CreateAltIds < ActiveRecord::Migration[6.0]
  def change
    create_table :alt_ids do |t|
      t.references :alt_id_type, foreign_key: true, null: false
      t.references :member, foreign_key: true, null: false
      t.string :value, null: false
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
