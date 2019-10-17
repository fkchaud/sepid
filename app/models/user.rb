# Usuario
class User < ApplicationRecord
  attribute :user_name, :string
  validates :user_name,
            presence: true,
            uniqueness: { scope: :is_disabled }
  attribute :password_digest, :string
  # validates :password_digest, presence: true
  # legajo = file_number
  attribute :file_number, :integer
  validates :file_number,
            presence: true,
            numericality: { greater_than: 0,
                            less_than: 999_999 },
            uniqueness: { scope: :is_disabled }
  attribute :last_name, :string
  validates :last_name, format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ ]*\z/,
                                  message: 'can only have letters and spaces' }
  attribute :first_name, :string
  validates :first_name, format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ ]*\z/,
                                   message: 'can only have letters and spaces' }
  attribute :email, :string
  attribute :telephone, :string
  attribute :cuil, :integer, limit: 8
  validates :cuil, numericality: { greater_than: 10_000_000_000,
                                   less_than: 99_999_999_999 },
                   allow_blank: true
  attribute :is_disabled, :datetime

  has_one :university_position
  belongs_to :user_profile
  scope :enabled, -> { where(is_disabled: nil) }
  scope :profile, ->(user_profile) { where(user_profile: user_profile) }
  has_many :projects_as_director,
           class_name: 'Project',
           inverse_of: :director
  has_many :projects_as_codirector,
           class_name: 'Project',
           inverse_of: :codirector

  def full_name
    names = []
    names << last_name.capitalize unless last_name.blank?
    names << first_name.capitalize unless first_name.blank?
    names.join(', ')
  end

  has_secure_password
end
