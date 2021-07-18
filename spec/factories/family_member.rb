# frozen_string_literal: true

FactoryBot.define do
  factory :family_member do
    is_active { 1 }
    is_primary_member { true }
  end
end
