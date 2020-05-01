# frozen_string_literal: true

require 'securerandom'

module SecureRandom
  BASE27_ALPHABET = ('0'..'9').to_a + ('A'..'Z').to_a - %w[0 1 O I A E U]

  # SecureRandom.base27 generates a random base27 string.
  #
  # The argument _n_ specifies the length, of the random string to be generated.
  #
  # If _n_ is not specified or is +nil+, 16 is assumed.
  #
  # The result may contain alphanumeric characters except 0, 1, O, I, A, E, and
  # U to avoid hard-to-differentiate characters and potentially offensive words
  #
  #   p SecureRandom.base27 # => "JA7T58M7LJ65XEX4"
  #   p SecureRandom.base27(9) # => "QUL7MNGQS"
  #
  def self.base27(n = 16)
    SecureRandom.random_bytes(n).unpack('C*').map { |byte|
      BASE27_ALPHABET[byte % 27]
    }.join
  end
end
