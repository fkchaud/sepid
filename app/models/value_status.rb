class ValueStatus < ApplicationRecord
  validates :value_status_name

  has_many :value_histories
end
