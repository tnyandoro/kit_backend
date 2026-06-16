class Administrator < ApplicationRecord
  has_secure_password

  ROLES = %w[super_admin staff].freeze

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :role, inclusion: { in: ROLES }

  after_initialize do
    self.role ||= "staff"
  end

  def super_admin?
    role == "super_admin"
  end

  def staff?
    role == "staff"
  end
end