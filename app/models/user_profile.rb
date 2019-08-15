class UserProfile < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :access_permits
end
