# frozen_string_literal: true

# User
#   grants access to the api through authentications
#   stores identifying information for a reservation
class User < ApplicationRecord
  enum user_type: {
    guest: 'guest'
  }

  has_many :authentications, inverse_of: :user, dependent: :destroy
  has_many :reservations, inverse_of: :user, dependent: :restrict_with_exception

  before_validation :set_identification_code, on: :create

  validates :identification_code, presence: true,
                                  uniqueness: { case_sensitive: true }
  validates :phone, format: { with: /\A\d{10}\z/ }, allow_blank: true

  private

  def set_identification_code
    loop do
      self.identification_code = SafeRandom.generate_code(6)

      break unless User.find_by(identification_code: identification_code)
    end
  end
end
