class User < ApplicationRecord
  enum user_type: {
    guest: 'guest'
  }

  has_many :authentications, inverse_of: :user, dependent: :destroy
  has_many :reservations, inverse_of: :user, dependent: :restrict_with_exception

  before_validation :set_id_code, on: :create

  validates :id_code, presence: true, uniqueness: true

  private

  def set_id_code
    loop do
      self.id_code = SecureRandom.generate_code(6)

      break unless User.find_by(id_code: id_code)
    end
  end
end
