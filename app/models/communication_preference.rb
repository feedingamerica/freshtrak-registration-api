# frozen_string_literal: true

# Communication Preference for Household Member
class CommunicationPreference < ApplicationRecord
  belongs_to :member, inverse_of: :communication_preference
  belongs_to :communication_preference_type

  validates :member_id,
            presence: true,
            uniqueness: { scope: :communication_preference_type_id }
  validates :communication_preference_type_id, presence: true
end
