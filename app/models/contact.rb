# frozen_string_literal: true

# Contact for a Household Member
class Contact < ApplicationRecord
  belongs_to :family, inverse_of: :contacts
  has_one :email, inverse_of: :contact, dependent: :destroy
  has_one :phone, inverse_of: :contact, dependent: :destroy
  has_one :address, inverse_of: :contact, dependent: :destroy

  validates :contact_type, presence: true
end