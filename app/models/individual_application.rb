class IndividualApplication < ApplicationRecord
  # Validations matching your admissionSchema
  validates :program, inclusion: { in: %w[youth student trainer workforce] }
  validates :mode_of_study, inclusion: { in: %w[full-time part-time online blended] }
  validates :full_name, :last_name, :nationality, presence: true
  validates :id_passport_number, presence: true, length: { minimum: 5 }
  validates :date_of_birth, :gender, :race, :home_address, :phone, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :has_disability, inclusion: { in: %w[yes no] }
  validates :qualification, inclusion: { in: %w[olevel alevel other] }
  validates :institution, :year_completed, :overall_result, presence: true
  
  # Set default status
  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= 'pending_review'
  end
end