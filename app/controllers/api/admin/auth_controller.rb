module Api
  module Admin
    class AuthController < ApplicationController
      def login
        email = params.dig(:auth, :email) || params[:email]
        password = params.dig(:auth, :password) || params[:password]

        admin = Administrator.find_by(email: email)

        if admin&.authenticate(password)
          token = JsonWebToken.encode(admin_id: admin.id)

          render json: {
            token: token,
            admin: {
              email: admin.email,
              role: admin.role
            }
          }
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end
    end
  end
end