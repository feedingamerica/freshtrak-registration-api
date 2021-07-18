# frozen_string_literal: true

FactoryBot.define do
  factory :family do
    seniors_in_family { 1 }
    adults_in_family { 1 }
    children_in_family { 1 }
  end
end
