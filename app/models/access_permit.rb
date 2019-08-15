class AccessPermit < ApplicationRecord
  validates :use_case_name, presence: true
  validates :use_case_url, presence: true


  has_and_belongs_to_many :user_profiles
end