# frozen_string_literal: true

# Phone for Household Member
class PhoneNumber < ApplicationRecord
  belongs_to :member, inverse_of: :phone
  belongs_to :location_type
  belongs_to :carrier_type

  validates :phone_number, presence: true,
                           format: { with: /\A\d{10}\z/ }
  validates :location_type_id, presence: true
  validates :carrier_type_id, presence: true
end
