# app/controllers/api/admin/dashboard_controller.rb
module Api
  module Admin
    class DashboardController < BaseController
      def stats
        render json: {
          total_students: IndividualApplication.count,
          total_organizations: OrganizationApplication.count,
          pending_students: IndividualApplication.where(status: 'pending_review').count,
          pending_orgs: OrganizationApplication.where(status: 'pending_review').count,
          accepted_students: IndividualApplication.where(status: 'accepted').count,
          accepted_orgs: OrganizationApplication.where(status: 'accepted').count,
        }
      end
    end
  end
end