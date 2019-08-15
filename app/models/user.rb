class User < ApplicationRecord
  has_one :university_position
  has_one :user_profile
  # to do: has_many proyectos (director)
  # to do: has_many proyectos (codirector)
end
