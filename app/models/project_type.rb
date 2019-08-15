class ProjectType < ApplicationRecord
  validates :name, presence: true
end
