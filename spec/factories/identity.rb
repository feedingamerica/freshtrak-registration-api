# frozen_string_literal: true

FactoryBot.define do
  factory :identity do
    user_id { user.id }
    provider_uid { Faker::Number.number(digits: 8) }
    provider { 'facebook' }
    created_at { Date.today.to_s.delete('-') }
    updated_at { Date.today.to_s.delete('-') }

    user
  end
end
