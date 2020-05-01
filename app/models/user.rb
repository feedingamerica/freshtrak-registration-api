class User < ApplicationRecord
  enum user_type: {
    guest: 'guest'
  }

  has_many :authentications, inverse_of: :user, dependent: :destroy
end
