# frozen_string_literal: true

# Generates codes of set length with limited characters
class SafeRandom
  # Use only lowercase letters to make it easy for users
  #   entering codes on smart phones
  # Exclude letters that could result in offensive codes
  SAFE_ALPHABET = (('a'..'z').to_a - %w[a e i o u l v]).freeze

  # Generates a variable length code with a provided character set
  #
  # @param [Integer] len desired length of the code
  # @param [Array<String>] charset array of allowed characters
  #
  # @return [String] the generated random code
  #
  # @example Generate a code
  #   SafeRandom.generate_code                   # => "nhrpwkpyyydjdpmf"
  #   SafeRandom.generate_code(4, ['X','Y','Z']) # => "YYXZ"
  #
  def self.generate_code(len = 16, charset = SAFE_ALPHABET)
    charset_size = charset.size
    SecureRandom.random_bytes(len).unpack('C*').map do |byte|
      charset[byte % charset_size]
    end.join
  end
end
