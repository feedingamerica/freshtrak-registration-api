# frozen_string_literal: true

FactoryBot.define do
  factory :authentication do
    user_id { user.id }
    token { '134568678lpdhgya_sample_token' }
    expires_at { Date.today.to_s.delete('-') }
    created_at { Date.today.to_s.delete('-') }
    updated_at { Date.today.to_s.delete('-') }

    user
  end
end
