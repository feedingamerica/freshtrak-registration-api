# frozen_string_literal: true

# Authentications to allow api access
class Authentication < ApplicationRecord
  EXPIRATION_PERIOD = 14.days

  has_secure_token

  before_create :set_expiry

  belongs_to :user, inverse_of: :authentications

  scope :unexpired, lambda {
    where(expires_at: Time.now..1.year.from_now)
  }

  def self.authenticate_with_token(token)
    unexpired.find_by(token: token)
  end

  private

  def set_expiry
    self.expires_at = Time.now + EXPIRATION_PERIOD
  end
end
