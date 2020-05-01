class User < ApplicationRecord
  enum user_type: {
    guest: 'guest'
  }

  has_many :authentications, inverse_of: :user, dependent: :destroy

  before_validation :set_identification_code, on: :create

  validates :identification_code, presence: true, uniqueness: true

  private

  def set_identification_code
    loop do
      self.identification_code = generate_identification_code

      break unless User.find_by(identification_code: identification_code)
    end
  end

  def generate_identification_code
    SecureRandom.base27(6).chars.each_slice(3).map(&:join).join('-')
  end
end
