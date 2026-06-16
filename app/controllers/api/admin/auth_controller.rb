module Api
  module Admin
    class AuthController < ApplicationController
      def login
        email = params[:email].to_s.strip.downcase
        password = params[:password]

        Rails.logger.info "========== ADMIN LOGIN =========="
        Rails.logger.info "EMAIL: #{email}"

        admin = Administrator.find_by(email: email)

        Rails.logger.info "ADMIN FOUND: #{admin.present?}"

        if admin
          Rails.logger.info "ADMIN ID: #{admin.id}"
          Rails.logger.info "ROLE: #{admin.role}"
          Rails.logger.info "PASSWORD DIGEST PRESENT: #{admin.password_digest.present?}"

          password_match = admin.authenticate(password).present?

          Rails.logger.info "PASSWORD MATCH: #{password_match}"

          if password_match
            token = JsonWebToken.encode(admin_id: admin.id)

            render json: {
              token: token,
              admin: {
                id: admin.id,
                email: admin.email,
                role: admin.role
              }
            }, status: :ok

            return
          end
        end

        Rails.logger.info "AUTH FAILED"

        render json: {
          error: "Invalid email or password"
        }, status: :unauthorized
      rescue => e
        Rails.logger.error "LOGIN ERROR: #{e.class}"
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.first(10).join("\n")

        render json: {
          error: "Login failed"
        }, status: :internal_server_error
      end
    end
  end
end