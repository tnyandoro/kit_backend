# app/controllers/api/admin/students_controller.rb
module Api
  module Admin
    class StudentsController < BaseController
      # GET /api/admin/students
      def index
        students = IndividualApplication.all
        
        # Basic search and filtering
        students = students.where("full_name ILIKE ? OR email ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%") if params[:query].present?
        students = students.where(status: params[:status]) if params[:status].present?
        students = students.where(program: params[:program]) if params[:program].present?

        render json: students.order(created_at: :desc)
      end

      # GET /api/admin/students/:id
      def show
        student = IndividualApplication.find(params[:id])
        render json: student
      end

      # PATCH /api/admin/students/:id/update_status
      def update_status
        student = IndividualApplication.find(params[:id])
        
        # Allowed statuses for the admin dashboard
        allowed_statuses = %w[pending_review accepted rejected activated]
        
        if allowed_statuses.include?(params[:status])
          student.update(status: params[:status])
          render json: { message: "Student status updated to #{params[:status]}", student: student }
        else
          render json: { error: "Invalid status" }, status: :unprocessable_entity
        end
      end
    end
  end
end