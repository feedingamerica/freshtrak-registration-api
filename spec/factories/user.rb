# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    user_type { 'guest' }
    first_name { 'nick' }
    last_name { 'harris' }
    created_at { Date.today.to_s.delete('-') }
    updated_at { Date.today.to_s.delete('-') }
  end
end
