module Api
  module Admin
    class DashboardController < BaseController
      before_action :require_staff_or_above!

      def stats
        render json: {
          total_students: IndividualApplication.count,
          total_organizations: OrganizationApplication.count,
          pending_students: IndividualApplication.where(status: "pending_review").count,
          pending_orgs: OrganizationApplication.where(status: "pending_review").count,
          accepted_students: IndividualApplication.where(status: "accepted").count,
          accepted_orgs: OrganizationApplication.where(status: "accepted").count
        }
      end
    end
  end
end