# frozen_string_literal: true

# A Member of a Family
class FamilyMember < ApplicationRecord
  belongs_to :family, inverse_of: :family_members
end
