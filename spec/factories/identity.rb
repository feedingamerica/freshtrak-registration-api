# frozen_string_literal: true

FactoryBot.define do
  factory :identity do
    user_id { user.id }
    provider_uid { '134568678' }
    provider_type { 'facebook' }
    auth_hash { 'sample_token_hhdkfh2455' }
    created_at { Date.today.to_s.delete('-') }
    updated_at { Date.today.to_s.delete('-') }

    user
  end
end
