# frozen_string_literal: true
#
# Event Registrations for a Household
class EventRegistration < ApplicationRecord
  belongs_to :household, inverse_of: :event_registrations
  belongs_to :event_status
  has_many :event_registration_members, dependent: :destroy

  validates :household_id, presence: true
  validates :event_status_id, presence: true
  validates :event_slot_id, presence: true
end