require "omniauth/strategies/oauth2"
require "base64"
require "digest"

module OmniAuth
  module Strategies
    class Lufthansa < OmniAuth::Strategies::OAuth2
      include ::Utils::Pkce

      option :name, "lufthansa"

      uid { access_token["id_token"] }

      def request_phase
        auth_code_verifier = generate_code_verifier
        auth_code_challenge = generate_code_challenge(auth_code_verifier)

        params = {
          code_challenge_method: "S256",
          code_challenge: auth_code_challenge,
          code_verifier: auth_code_verifier,
          redirect_uri: callback_url,
        }.merge(authorize_params)

        redirect client.auth_code.authorize_url(params)
      end

      def callback_url
        (full_host + script_name + callback_path)
      end
    end
  end
end


# def request_phase
#   params = authorize_params.dup
#
#   if authorize_params.code_challenge_method.nil?
#     params[:code_challenge_method] = ::Utils::Pkce.default_method
#   end
#
#   auth_code_verifier = generate_code_verifier
#   auth_code_challenge =
#     if params.code_challenge_method == ::Utils::Pkce.default_method
#       auth_code_verifier
#     else
#       generate_code_challenge(auth_code_verifier)
#     end
#
#   params =
#     params.merge(
#       code_challenge: auth_code_challenge,
#       code_verifier: auth_code_verifier,
#       redirect_uri: callback_url,
#     )
#
#   redirect client.auth_code.authorize_url(params)
# end
