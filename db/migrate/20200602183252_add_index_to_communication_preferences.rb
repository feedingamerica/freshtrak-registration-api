# frozen_string_literal: true

# Add Index to Communication Preferences
class AddIndexToCommunicationPreferences < ActiveRecord::Migration[6.0]
  def change
    add_index :communication_preferences,
              %i[household_member_id communication_preference_type_id],
              unique: true,
              name: 'uq_communication_pref_member'
  end
end
