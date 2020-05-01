# frozen_string_literal: true

require 'securerandom'

module SecureRandom
  # Use only lowercase letters to make it easy for users 
  #   entering codes on smart phones
  # Exclude letters that could result in offensive codes
  SAFE_ALPHABET = (('a'..'z').to_a - %w[a e i o u l v]).freeze

  # Generates a variable length code with a provided character set
  #
  # @param [Integer] n desired length of the code
  # @param [Array<String>] charset array of allowed characters 
  #
  # @return [String] the generated random code
  #
  # @example Generate a code
  #   SecureRandom.generate_code                   # => "nhrpwkpyyydjdpmf"
  #   SecureRandom.generate_code(4, ['X','Y','Z']) # => "YYXZ"
  #
  def self.generate_code(n = 16, charset = SAFE_ALPHABET)
    charset_size = charset.size
    SecureRandom.random_bytes(n).unpack('C*').map { |byte|
      charset[byte % charset_size]
    }.join
  end
end
