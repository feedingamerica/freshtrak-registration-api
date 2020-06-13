# frozen_string_literal: true

# A Member of a Household, relates to a User
class Member < ApplicationRecord
  belongs_to :household, inverse_of: :members
  belongs_to :user, inverse_of: :member
  belongs_to :suffix
  belongs_to :gender
  has_many :alt_ids, inverse_of: :member, dependent: :destroy

  validates :number, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :gender_id, presence: true
end
