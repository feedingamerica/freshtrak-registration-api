class CreateCommunicationPreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :communication_preferences do |t|
      t.references :member, foreign_key: true, null: false
      t.references :communication_preference_type, foreign_key: true, null: false, index: { name: 'fk_communication_pref_type' }
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
