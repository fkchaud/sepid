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
            numericality: { greater_than: 0 },
            uniqueness: { scope: :is_disabled }
  attribute :last_name, :string
  attribute :first_name, :string
  attribute :email, :string
  attribute :telephone, :string
  attribute :cuil, :integer, limit: 8
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
    "#{last_name.capitalize}, #{first_name.capitalize}"
  end
  has_secure_password
end
