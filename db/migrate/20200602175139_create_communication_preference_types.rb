class CreateCommunicationPreferenceTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :communication_preference_types do |t|
      t.string :name, null: false
      t.string :description, null: true
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
