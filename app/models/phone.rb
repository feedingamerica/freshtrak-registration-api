# frozen_string_literal: true

# Phone for Household Member
class Phone < ApplicationRecord
  belongs_to :person

  validates :phone_number, presence: true,
                           format: { with: /\A\d{10}\z/ }
end
