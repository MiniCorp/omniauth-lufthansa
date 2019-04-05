module Utils
  module Pkce
    def self.default_method
      "plain".freeze
    end

    MIN_LENGTH = 43
    MAX_LENGTH = 128
    LETTERS =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".freeze

    def generate_code_verifier
      code_verifier_length =
        MIN_LENGTH + (rand(0..MAX_LENGTH) % (MAX_LENGTH - MIN_LENGTH))

      code_verifier = ""

      (0..code_verifier_length).each do
        rand_letter_index = rand(0..LETTERS.length - 1)
        next_char = LETTERS[rand_letter_index]
        code_verifier += next_char
      end

      base64_code_verifier = Base64.urlsafe_encode64(code_verifier)
      base64_code_verifier = base64_code_verifier.gsub("=", "")
      base64_code_verifier = base64_code_verifier.gsub("+", "-")
      base64_code_verifier = base64_code_verifier.gsub("/", "-")
      base64_code_verifier
    end

    def generate_code_challenge(code_verifier)
      # get the sha256 hash for the verifier
      sha256_data = Digest::SHA256.digest(code_verifier)
      # convert back to Base64 string
      code_challenge = Base64.urlsafe_encode64(sha256_data)
      code_challenge = code_challenge.gsub("=", "")
      code_challenge = code_challenge.gsub("+", "-")
      code_challenge = code_challenge.gsub("/", "-")
      code_challenge
    end
  end
end
