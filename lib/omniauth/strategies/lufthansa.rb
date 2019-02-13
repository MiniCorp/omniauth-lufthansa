require "omniauth/strategies/oauth2"
require "base64"
require "digest"

module OmniAuth
  module Strategies
    class Lufthansa < OmniAuth::Strategies::OAuth2
      MIN_LENGTH = 43
      MAX_LENGTH = 128
      LETTERS =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".freeze

      def self.code_verifier
        @code_verifier ||= begin
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
      end

      def self.code_challenge(code_verifier)
        @code_challenge ||= begin
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

      option :name, "lufthansa"

      option(
        :authorize_params,
        code_challenge: Lufthansa.code_challenge(Lufthansa.code_verifier),
        code_challenge_method: "S256",
      )

      option(
        :token_params,
        code_verifier: Lufthansa.code_verifier,
      )

      uid { access_token["id_token"] }

      def callback_url
        (full_host + script_name + callback_path)
      end
    end
  end
end
