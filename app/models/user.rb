# Usuario
class User < ApplicationRecord
  validates :user_name, presence: true
  validates :password, presence: true
  # legajo = file_number
  validates :file_number, presence: true, numericality: { greater_than: 0 }

  has_one :university_position
  has_one :user_profile
  # TODO: testear si andan estos dos
  has_many :projects_as_director,
           class_name: 'Project',
           inverse_of: :director
  has_many :projects_as_codirector,
           class_name: 'Project',
           inverse_of: :codirector
end
