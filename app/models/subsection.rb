# Subsection = Inciso
class Subsection < ApplicationRecord
  validates :name, presence: true
  # has many DetalleFondoProyecto (name?)
  # has many order_details (DetallePedido)
end
