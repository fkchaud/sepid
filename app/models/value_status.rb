# EstadoValor
class ValueStatus < ApplicationRecord
  validates :value_status_name, presence: true

  has_many :value_histories
end
