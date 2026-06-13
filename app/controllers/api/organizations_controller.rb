# app/controllers/api/admin/organizations_controller.rb
module Api
  module Admin
    class OrganizationsController < BaseController
      # GET /api/admin/organizations
      def index
        orgs = OrganizationApplication.all
        
        orgs = orgs.where("institution_name ILIKE ? OR email ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%") if params[:query].present?
        orgs = orgs.where(status: params[:status]) if params[:status].present?

        render json: orgs.order(created_at: :desc)
      end

      # GET /api/admin/organizations/:id
      def show
        org = OrganizationApplication.find(params[:id])
        render json: org
      end

      # PATCH /api/admin/organizations/:id/update_status
      def update_status
        org = OrganizationApplication.find(params[:id])
        allowed_statuses = %w[pending_review accepted rejected activated]
        
        if allowed_statuses.include?(params[:status])
          org.update(status: params[:status])
          render json: { message: "Organization status updated to #{params[:status]}", organization: org }
        else
          render json: { error: "Invalid status" }, status: :unprocessable_entity
        end
      end
    end
  end
end