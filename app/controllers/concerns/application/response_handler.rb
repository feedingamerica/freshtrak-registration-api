# frozen_string_literal: true

# Generalised Response Handlers
module Application
  # Response Handler
  module ResponseHandler
    extend ActiveSupport::Concern

    def serializer
      ActiveModelSerializers::SerializableResource
    end

    def render_set_collection(collection)
      data = collection
      render status: :ok, json: {
        status_code: 200,
        message: 'Data retrieved successfully',
        data: data
      }
    end

    def render_message(message, code)
      # response.header['Access-Control-Expose-Headers'] = "Content-Range"
      # response.header['Content-Range'] = 1
      render status: :ok, json: {
        status_code: code,
        message: message
      }
    end
  end
end
