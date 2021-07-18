# frozen_string_literal: true

FactoryBot.define do
  factory :phone do
    phone { '2034916636' }
    is_primary { false }
    permission_to_text { false }
  end
end
