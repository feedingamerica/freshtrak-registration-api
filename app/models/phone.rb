# frozen_string_literal: true

# Phone for Household Member
class Phone < ApplicationRecord
  belongs_to :contact, inverse_of: :phone

  validates :phone, presence: true
end
