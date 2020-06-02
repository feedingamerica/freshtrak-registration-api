class AddIndexToCommunicationPreferences < ActiveRecord::Migration[6.0]
  def change
    add_index :communication_preferences, [:member_id, :communication_preference_type_id], unique: true, name: 'uq_communication_pref_member'
  end
end
