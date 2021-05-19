# frozen_string_literal: true

# Person information
class Person < ApplicationRecord
  has_many :addresses, inverse_of: :person, dependent: :restrict_with_exception
  has_many :phones, inverse_of: :person, dependent: :restrict_with_exception
  has_many :emails, inverse_of: :person, dependent: :restrict_with_exception
  belongs_to :user, inverse_of: :person, dependent: :destroy
  belongs_to :family_member, inverse_of: :person, dependent: :destroy
end
