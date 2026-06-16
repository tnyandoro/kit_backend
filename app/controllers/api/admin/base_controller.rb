module Api
  module Admin
    class BaseController < ApplicationController
      before_action :authenticate_admin!

      attr_reader :current_admin

      private

      def authenticate_admin!
        token = request.headers["Authorization"]&.split(" ")&.last
        decoded = JsonWebToken.decode(token)

        if decoded.blank? || decoded[:admin_id].blank?
          render json: { error: "Unauthorized" }, status: :unauthorized and return
        end

        @current_admin = Administrator.find_by(id: decoded[:admin_id])

        unless @current_admin
          render json: { error: "Unauthorized" }, status: :unauthorized and return
        end

      rescue JWT::DecodeError, JWT::ExpiredSignature
        render json: { error: "Token invalid or expired" }, status: :unauthorized and return
      end

      def require_super_admin!
        unless current_admin&.super_admin?
          render json: { error: "Forbidden: super admin only" }, status: :forbidden and return
        end
      end

      def require_staff_or_above!
        unless current_admin&.staff? || current_admin&.super_admin?
          render json: { error: "Forbidden" }, status: :forbidden and return
        end
      end
    end
  end
end