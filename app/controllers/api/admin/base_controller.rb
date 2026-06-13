module Api
  module Admin
    class BaseController < ApplicationController
      before_action :authenticate_admin!

      private

      def authenticate_admin!
        token = request.headers['Authorization']&.split(' ')&.last
        
        begin
          decoded = JsonWebToken.decode(token)
          # This MUST say Administrator, not AdminUser
          @current_admin = Administrator.find(decoded[:admin_id])
        rescue JWT::DecodeError, ActiveRecord::RecordNotFound
          render json: { error: "Unauthorized. Invalid or missing token." }, status: :unauthorized
        end
      end
    end
  end
end
