# frozen_string_literal: true

# Email for a Household Member
class Email < ApplicationRecord
  belongs_to :member, inverse_of: :email
  belongs_to :location_type

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :location_type_id, presence: true
end
