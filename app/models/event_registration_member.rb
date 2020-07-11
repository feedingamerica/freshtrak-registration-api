# frozen_string_literal: true

# Relationship between Event Registration and Household Member
class EventRegistrationMember < ApplicationRecord
  belongs_to :event_registration, inverse_of: :event_registration_members
  belongs_to :household_member

  validates :event_registration_id, presence: true
  validates :member_id, presence: true
end
