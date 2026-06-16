# app/controllers/concerns/jwt_authenticatable.rb
module JwtAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authorize_request
    attr_reader :current_admin
  end

  private

  def authorize_request
    header = request.headers["Authorization"]

    token = header&.split(" ")&.last
    decoded = JsonWebToken.decode(token)

    if decoded.nil? || decoded[:admin_id].blank?
      render json: { error: "Unauthorized" }, status: :unauthorized and return
    end

    @current_admin = Administrator.find_by(id: decoded[:admin_id])

    unless @current_admin
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end