# frozen_string_literal: true
#
# User Credential for OmniAuth
class Credential < ApplicationRecord
  belongs_to :user, inverse_of: :credential

  validates :token, presence: true
end