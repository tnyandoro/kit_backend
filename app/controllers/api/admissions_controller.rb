# app/controllers/api/admissions_controller.rb
module Api
  class AdmissionsController < ApplicationController
    # (We removed the skip_before_action line here)

    # POST /api/admissions/create
    def create
      # Transform camelCase keys from frontend to snake_case for Rails
      permitted_params = individual_params.to_h.transform_keys(&:underscore)

      application = IndividualApplication.new(permitted_params)

      if application.save
        render json: { message: "Individual application submitted successfully!", id: application.id }, status: :created
      else
        render json: { message: "Validation failed", errors: application.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # POST /api/admissions/organization
    def create_organization
      permitted_params = organization_params.to_h.transform_keys(&:underscore)

      application = OrganizationApplication.new(permitted_params)

      if application.save
        render json: { message: "Organization application submitted successfully!", id: application.id }, status: :created
      else
        render json: { message: "Validation failed", errors: application.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # GET /api/admissions/individuals
    def individuals
      # Fetch all applications and return them as JSON
      render json: IndividualApplication.all.order(created_at: :desc)
    end

    private

    # Permit the exact camelCase keys sent by your React frontend
    def individual_params
      params.permit(
        :program, :modeOfStudy, :fullName, :lastName, :idPassportNumber,
        :dateOfBirth, :gender, :nationality, :race, :homeAddress, :phone,
        :email, :hasDisability, :disabilityDetails, :qualification, :institution,
        :yearCompleted, :overallResult, :employer, :position, :duration, :additionalInformation
      )
    end

    def organization_params
      params.permit(
        :institutionName, :institutionType, :registrationNumber, :taxNumber,
        :industrySector, :physicalAddress, :cityProvinceCountry, :gpsCoordinates,
        :contactPersonFullName, :contactPersonPosition, :email, :phone,
        :program, :numberOfTrainees, :additionalInformation
      )
    end
  end
end
