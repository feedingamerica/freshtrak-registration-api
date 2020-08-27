# frozen_string_literal: true

# Creates an Identity for external users like facebook, google..
class Identity < ApplicationRecord
  belongs_to :user, inverse_of: :identities
end
