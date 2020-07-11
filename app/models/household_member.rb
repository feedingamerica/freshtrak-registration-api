# frozen_string_literal: true

# A Member of a Household, relates to a User
class HouseholdMember < ApplicationRecord
  belongs_to :household, inverse_of: :household_members
  belongs_to :user, inverse_of: :household_member
  belongs_to :suffix
  belongs_to :gender
  has_many :alt_ids, inverse_of: :household_member, dependent: :destroy

  validates :number, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :gender_id, presence: true
end
