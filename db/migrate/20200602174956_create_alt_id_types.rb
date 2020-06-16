# frozen_string_literal: true

# Create Alt Id Types table
class CreateAltIdTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :alt_id_types do |t|
      t.string :name, null: false
      t.string :description, null: true
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
