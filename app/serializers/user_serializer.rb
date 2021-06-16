# frozen_string_literal: true

# Defines User attributes to be returned in JSON
class UserSerializer < ApplicationSerializer
  attributes :id, :user_type

  has_one :person
end
