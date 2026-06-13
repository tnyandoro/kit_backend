# app/controllers/api/admin/auth_controller.rb
module Api
  module Admin
    class AuthController < ApplicationController
      def login
        admin = AdminUser.find_by(email: params[:email])
        
        if admin&.authenticate(params[:password])
          token = JsonWebToken.encode(admin_id: admin.id)
          render json: { 
            token: token, 
            admin: { email: admin.email, role: admin.role } 
          }
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end
    end
  end
end