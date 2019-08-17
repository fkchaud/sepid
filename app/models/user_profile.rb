# PerfilUsuario
class UserProfile < ApplicationRecord
  attribute :name, :string
  validates :name, presence: true
  attribute :description, :string
  attribute :is_disabled, :datetime, default: nil

  has_and_belongs_to_many :access_permits
  has_many :users
end
