# frozen_string_literal: true

# Address for Household Member
class Address < ApplicationRecord
  belongs_to :person, inverse_of: :addresses

  validates :state,
            length: { is: 2 },
            on: :create

  validates :zip_code,
            length: { is: 5 },
            on: :create
end
