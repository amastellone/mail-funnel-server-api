#lib/json_web_token.rb
require 'jwt'

class JsonWebToken
	def self.encode(payload, expiration = 24.hours.from_now)
		payload = payload.dup
		payload['exp'] = expiration.to_i
		JWT.encode(payload, Rails.application.secrets.json_web_token_secret)
	end

	def self.decode(token)
		JWT.decode(token, Rails.application.secrets.json_web_token_secret)
	end
end

# https://auth0.com/blog/ruby-authentication-secure-rack-apps-with-jwt/

# https://rails-api-jwt.herokuapp.com/api/docs/

#app/controllers/api/base_controller.rb
# class Api::BaseController < ApplicationController
class SecondApi < ApplicationController
	include ActionController::ImplicitRender
	respond_to :json

	before_filter :authenticate_user_from_token!

	protected

	def authenticate_user_from_token!
		if claims and user = User.find_by(email: claims[0]['user'])
			@current_user = user
		else
			return render_unauthorized errors: { unauthorized: ["You are not authorized perform this action."] }
		end
	end

	def claims
		auth_header = request.headers['Authorization'] and
			 token = auth_header.split(' ').last and
			 ::JsonWebToken.decode(token)
	rescue
		nil
	end

	def jwt_token user
		JsonWebToken.encode('user' => user.email)
	end

	def render_unauthorized(payload)
		render json: payload.merge(response: { code: 401 })
	end

end