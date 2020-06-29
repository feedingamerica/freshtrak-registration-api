# frozen_string_literal: true

# The address associated with a household
class HouseholdAddress < ApplicationRecord
  belongs_to :household, inverse_of: :address

  validates :state,
            length: { is: 2 },
            on: :create

  validates :zip_code,
            length: { is: 5 },
            on: :create

  validates :zip_4,
            length: { is: 4 },
            allow_nil: true,
            on: :create
end
