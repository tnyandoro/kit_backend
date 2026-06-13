module Api
  module Admin
    class OrganizationsController < BaseController
      def index
        orgs = OrganizationApplication.all
        orgs = orgs.where("institution_name ILIKE ? OR email ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%") if params[:query].present?
        orgs = orgs.where(status: params[:status]) if params[:status].present?
        render json: orgs.order(created_at: :desc)
      end

      def show
        org = OrganizationApplication.find(params[:id])
        render json: org
      end

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
