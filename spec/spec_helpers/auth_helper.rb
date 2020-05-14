# frozen_string_literal: true

module AuthHelper
  def sign_in_api(user)
    auth = user.authentications.create!
    request.headers.merge!(authorization: "Bearer #{auth.token}")
  end
end
