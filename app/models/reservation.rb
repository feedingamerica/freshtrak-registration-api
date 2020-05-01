class Reservation < ApplicationRecord
  belongs_to :user, inverse_of: :reservations
end
