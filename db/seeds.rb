# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ResolutionType.create [
  {
    name: 'Resolución de Fondos',
    description: 'Nueva asignación de fondos enviados por rectorado.'
  },
  {
    name: 'Resolución de Remanentes',
    description: 'Asignación de fondos sobrantes de años anteriores.'
  }
]

SubsectionShiftStatus.create [
  { name: 'Solicitado' }, { name: 'Aprobado' }, { name: 'Rechazado' }
]

Subsection.create [
  { name: '2' }, { name: '3' }, { name: '4.3' }
]

ValueStatus.create [
  { value_status_name: 'Estimado' }, { value_status_name: 'Preventivo' },
  { value_status_name: 'Final' }, { value_status_name: 'Cancelado' },
  { value_status_name: 'Rechazado' }
]

# carga segun resolucion 715/2018 de Rectorado
# http://csu.rec.utn.edu.ar/docs/php/salida_nuevo_sitio_rectorado.php3?tipo=RES&numero=715%anio=2018%facultad=CSU
UniversityPosition.create [
  { name: 'Consejero Superior',            per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Jurado de Concurso Docente',    per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Jurado de Concurso Nodocente',  per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Autoridad de Rectorado',        per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Autoridad de Unidad Académica', per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Otros Cargos',                  per_travel_payment: 1560.0, per_lunch_payment: 360.0 }
]

ProjectType.create [
  { name: 'PID', purpose: '03 - Servicios Sociales', function: '05 - Ciencia y Técnica',
    program: '18 - Investigación', activity: '02 - Investigación Aplicada',
    financing: '11 - Contribución del Tesoro' }
]

ProjectStatus.create [
  { name: 'Aprobado' }, { name: 'En ejecución' }, { name: 'Finalizado' }, { name: 'Cancelado' }
]

OrderStatus.create [
  { order_status_name: 'Pedido realizado', allow_cancel_order: true },
  { order_status_name: 'Pedido rechazado', allow_cancel_order: false },
  { order_status_name: 'Pedido cancelado', allow_cancel_order: false },
  { order_status_name: 'Aprobado por CYT', allow_cancel_order: true },
  { order_status_name: 'Aprobado por Secretario', allow_cancel_order: true },
  { order_status_name: 'Armado y aprobación de preventivo', allow_cancel_order: true },
  { order_status_name: 'Licitación iniciada', allow_cancel_order: true },
  { order_status_name: 'Devengado realizado', allow_cancel_order: false },
  { order_status_name: 'Pedido recibido', allow_cancel_order: false },
  { order_status_name: 'Pedido retirado', allow_cancel_order: false }
]

# UserProfile & AccessPermit

# crear tipos de pedidos
