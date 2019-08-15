class User < ApplicationRecord
  validates :user_name, presence: true
  validates :password, presence: true
  # legajo
  validates :file_number, presence: true, numericality: { greater_than: 0 }

  has_one :university_position
  has_one :user_profile
  # to do: has_many proyectos (director)
  # to do: has_many proyectos (codirector)
end
