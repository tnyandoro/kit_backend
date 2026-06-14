module Api
  module Admin
    class StudentsController < BaseController
      before_action :set_student, only: [:show, :update_status]

      ALLOWED_STATUSES = %w[pending_review accepted rejected activated].freeze

      def index
        students = IndividualApplication.all

        if params[:query].present?
          query = "%#{params[:query]}%"
          students = students.where(
            "full_name ILIKE :q OR email ILIKE :q",
            q: query
          )
        end

        students = students.where(status: params[:status]) if params[:status].present?
        students = students.where(program: params[:program]) if params[:program].present?

        render json: students.order(created_at: :desc)
      end

      def show
        render json: @student
      end

      def update_status
        status = params[:status].to_s

        unless ALLOWED_STATUSES.include?(status)
          return render json: { error: "Invalid status" }, status: :unprocessable_entity
        end

        if @student.update(status: status)
          render json: {
            message: "Student status updated to #{status}",
            student: @student
          }
        else
          render json: { error: @student.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_student
        @student = IndividualApplication.find(params[:id])
      end
    end
  end
end