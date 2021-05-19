# frozen_string_literal: true

# Phone for Household Member
class Phone < ApplicationRecord
  belongs_to :person, inverse_of: :phones

  validates :phone, presence: true
end
