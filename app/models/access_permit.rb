# PermisoAcceso
class AccessPermit < ApplicationRecord
  attribute :use_case_name, :string
  validates :use_case_name, presence: true
  attribute :use_case_url, :string
  validates :use_case_url, presence: true

  has_and_belongs_to_many :user_profiles
end