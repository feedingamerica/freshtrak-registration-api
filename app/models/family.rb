# frozen_string_literal: true

# A collection of families
class Family < ApplicationRecord
  # Active Record implicitly creates the primary key as 'id.'

  # Determines table relationships.
  has_many :family_members, inverse_of: :family, dependent: :destroy
end
