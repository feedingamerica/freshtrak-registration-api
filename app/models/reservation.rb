# frozen_string_literal: true

# Reserves a slot at an agency event for a user
class Reservation < ApplicationRecord
  belongs_to :user, inverse_of: :reservations
end
