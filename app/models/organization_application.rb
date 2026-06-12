class OrganizationApplication < ApplicationRecord
  # Validations matching your organizationSchema
  validates :institution_name, :industry_sector, :physical_address, presence: true
  validates :institution_type, inclusion: { in: %w[primary highschool private government ngo other] }
  validates :registration_number, :contact_person_full_name, :contact_person_position, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true, length: { minimum: 10 }
  validates :program, inclusion: { in: %w[youth student trainer workforce] }
  validates :number_of_trainees, presence: true, numericality: { greater_than: 0 }

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= 'pending_review'
  end
end