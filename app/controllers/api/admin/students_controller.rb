module Api
  module Admin
    class StudentsController < BaseController

      def index
        require_staff_or_above!

        students = IndividualApplication.all
        render json: students.order(created_at: :desc)
      end

      def show
        require_staff_or_above!

        student = IndividualApplication.find(params[:id])
        render json: student
      end

      def destroy
        require_super_admin!

        student = IndividualApplication.find(params[:id])
        student.destroy

        render json: { message: "Deleted" }
      end

      def update_status
        require_staff_or_above!

        student = IndividualApplication.find(params[:id])
        allowed_statuses = %w[pending_review accepted rejected activated]

        if allowed_statuses.include?(params[:status])
          student.update(status: params[:status])
          render json: { message: "Updated", student: student }
        else
          render json: { error: "Invalid status" }, status: :unprocessable_entity
        end
      end

    end
  end
end