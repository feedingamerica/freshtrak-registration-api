# frozen_string_literal: true

# All other serializer inherit from ApplicationSerializer.
class ApplicationSerializer < ActiveModel::Serializer
  def new_record
    object.created_at == object.updated_at
  end
end
