# frozen_string_literal: true

# Defines Authentication attributes to be returned in JSON
class AuthenticationSerializer < ApplicationSerializer
  attributes :id, :user_id, :token, :expires_at, :created_at, :updated_at
  attribute :new_record
end
