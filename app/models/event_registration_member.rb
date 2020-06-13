# frozen_string_literal: true
#
# Relationship between Event Registration and Household Member
class EventRegistrationMember < ApplicationRecord
  belongs_to :event_registration, inverse_of: :event_registration_members
  belongs_to :member
end