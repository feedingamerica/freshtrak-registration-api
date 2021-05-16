# frozen_string_literal: true

# Email for a Household Member
class Email < ApplicationRecord
  belongs_to :person

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
end
