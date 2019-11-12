# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts '-- create resolution_types'
ResolutionType.create! [
  {
    name: 'Resolución de Fondos',
    description: 'Nueva asignación de fondos enviados por rectorado.'
  },
  {
    name: 'Resolución de Remanentes',
    description: 'Asignación de fondos sobrantes de años anteriores.'
  }
]
funds_resolution = ResolutionType.find_by_name 'Resolución de Fondos'

puts '-- create subsection_shift_statuses'
SubsectionShiftStatus.create! [
  { name: 'Solicitado' },
  { name: 'Aprobado'   },
  { name: 'Rechazado'  }
]

puts '-- create subsections'
subsections = Subsection.create! [
  { name: '2'   },
  { name: '3'   },
  { name: '4.3' }
]

puts '-- create value_statuses'
ValueStatus.create! [
  { value_status_name: 'Estimado'   },
  { value_status_name: 'Preventivo' },
  { value_status_name: 'Final'      },
  { value_status_name: 'Cancelado'  },
  { value_status_name: 'Rechazado'  }
]

# carga segun resolucion 715/2018 de Rectorado
# http://csu.rec.utn.edu.ar/docs/php/salida_nuevo_sitio_rectorado.php3?tipo=RES&numero=715%anio=2018%facultad=CSU
puts '-- create university_positions'
UniversityPosition.create! [
  { name: 'Consejero Superior',            per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Jurado de Concurso Docente',    per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Jurado de Concurso Nodocente',  per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Autoridad de Rectorado',        per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Autoridad de Unidad Académica', per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Otros Cargos',                  per_travel_payment: 1560.0, per_lunch_payment: 360.0 }
]

puts '-- create project_types'
ProjectType.create! [
  { name: 'PID', purpose: '03 - Servicios Sociales', function: '05 - Ciencia y Técnica',
    program: '18 - Investigación', activity: '02 - Investigación Aplicada',
    financing: '11 - Contribución del Tesoro' },
  { name: 'PID IN', purpose: '03 - Servicios Sociales', function: '05 - Ciencia y Técnica',
    program: '18 - Investigación', activity: '02 - Investigación Aplicada',
    financing: '11 - Contribución del Tesoro' }
]
project_type_pid = ProjectType.find_by_name('PID')
project_type_pid_in = ProjectType.find_by_name('PID IN')

puts '-- create project_statuses'
ProjectStatus.create! [
  { name: 'Aprobado'     },
  { name: 'En ejecución' },
  { name: 'Finalizado'   },
  { name: 'Cancelado'    }
]
project_status_approved = ProjectStatus.find_by_name('Aprobado')

puts '-- create order_statuses'
OrderStatus.create! [
  { order_status_name: 'Pedido realizado',                  allow_cancel_order: true  },
  { order_status_name: 'Pedido rechazado',                  allow_cancel_order: false },
  { order_status_name: 'Pedido cancelado',                  allow_cancel_order: false },
  { order_status_name: 'Aprobado por CYT',                  allow_cancel_order: true  },
  { order_status_name: 'Aprobado por Secretario',           allow_cancel_order: true  },
  { order_status_name: 'Armado y aprobación de preventivo', allow_cancel_order: true  },
  { order_status_name: 'Licitación iniciada',               allow_cancel_order: true  },
  { order_status_name: 'Devengado realizado',               allow_cancel_order: false },
  { order_status_name: 'Pedido recibido',                   allow_cancel_order: false },
  { order_status_name: 'Pedido retirado',                   allow_cancel_order: false }
]

puts '-- create user_profiles'
UserProfile.create! [
  { name: 'Investigador' },
  { name: 'Super_Admin'  },
  { name: 'DEF_Admin'    },
  { name: 'SeCYT_Sec'    },
  { name: 'SeCYT_Admin'  }
]

puts '-- create users'
User.create! [
  {
    user_name: 'admin',
    password: '12345678',
    file_number: 1,
    last_name: 'Admin',
    email: 'sepid.UTN@gmail.com',
    user_profile: UserProfile.find_by_name('Super_Admin')
  },
  {
    user_name: 'victor',
    password: '12345678',
    file_number: 2,
    last_name: 'Oliva',
    first_name: 'Víctor',
    email: 'sepid.UTN@gmail.com',
    user_profile: UserProfile.find_by_name('SeCYT_Admin')
  },
  {
    user_name: 'cesar',
    password: '12345678',
    file_number: 3,
    first_name: 'Cesar',
    email: 'sepid.UTN@gmail.com',
    user_profile: UserProfile.find_by_name('DEF_Admin')
  },
  {
    user_name: 'bromberg',
    password: '12345678',
    file_number: 4,
    last_name: 'Bromberg',
    first_name: 'Facundo',
    email: 'sepid.UTN@gmail.com',
    user_profile: UserProfile.find_by_name('Investigador')
  },
  {
    user_name: 'investigador2',
    password: '12345678',
    file_number: 5,
    last_name: 'Investigador',
    first_name: 'Dos',
    email: 'sepid.UTN@gmail.com',
    user_profile: UserProfile.find_by_name('Investigador')
  },
  {
    user_name: 'vazquez',
    password: '12345678',
    file_number: 6,
    last_name: 'Vazquez',
    first_name: 'Alejandro',
    email: 'sepid.UTN@gmail.com',
    user_profile: UserProfile.find_by_name('Investigador')
  },
  {
    user_name: 'cortez',
    password: '12345678',
    file_number: 7,
    last_name: 'Cortez',
    first_name: 'Alberto',
    email: 'sepid.UTN@gmail.com',
    user_profile: UserProfile.find_by_name('Investigador')
  }
]
user_bromberg = User.find_by_user_name('bromberg')
user_inv2 = User.find_by_user_name('investigador2')
user_vazquez = User.find_by_user_name('vazquez')
user_cortez = User.find_by_user_name('cortez')

no_incentives_codes = 'UTN5007,UTN4508,UTN4544,UTN4623,INN3986,' \
                      'UTN4564,IAN4037,IAN4940,UTN4046,UTN4343,IFN4491,UTN4450,' \
                      'UTN4529,INN4556,UTN4455,UTN4624,UTN4063,UTN3965,IAN4514,' \
                      'UTN4582,UTN4920,INN5014,UTN4092,UTN4625,UTN4528,UTN4805,' \
                      'UTN4741'.split(',')

puts '-- create no incentived projects'
no_incentives_projects = Project.create!(
  no_incentives_codes.map do |code|
    {
      project_code: code,
      project_name: "Project #{code}",
      start_date: '2019-01-01',
      ending_date: '2019-12-31',
      project_status: project_status_approved,
      project_type: project_type_pid,
      director: user_bromberg,
      codirector: user_inv2
    }
  end
)

incentives_codes =  'UTI3601,UTI4481,UTI4368,INI3878,' \
                    'OTI4087,UTI4335,UTI4404,UTI4523,UTI4880,UTI4588,UTI4615,UTI4905,' \
                    'INI4600,UTI4035,IFI3954,UTI4596,UTI4030,UTI4814,UTI4915,UTI4736,' \
                    'UTI4413,UTI4034'.split(',')

puts '-- create incentived projects'
incentives_projects = Project.create!(
  incentives_codes.map do |code|
    {
      project_code: code,
      project_name: "Project #{code}",
      start_date: '2019-01-01',
      ending_date: '2019-12-31',
      project_status: project_status_approved,
      project_type: project_type_pid, # maybe change to pid with incentives in the future
      director: user_bromberg,
      codirector: user_inv2
    }
  end
)

showable_projects = Project.create! [{
  project_code: 'INI7640',
  project_name: 'Integración y calidad del desarrollo de Software dirigido por modelos en entornos Ágiles',
  start_date: '2019-01-01',
  ending_date: '2020-12-31',
  project_status: project_status_approved,
  project_type: project_type_pid_in,
  director: user_vazquez,
  codirector: user_cortez,
  technological_scientific_unit: 'FR Mendoza - GRUPO AUSEGTIC. GRUPO DE INVESTIGACIÓN Y SERVICIOS DE AUDITORÍA Y SEGURIDAD DE TIC',
  project_program: 'Sistemas de Información e Informática',
  activity_type: 'Investigación Aplicada'
}]
incentives_projects += showable_projects

puts '-- create non incentived project_funds_details'
no_incentives_pfds = ProjectFundsDetail.create!(
  no_incentives_projects.map { |project|
    {
      funds_amount: 267_300.0 / no_incentives_projects.length,
      year: 2019,
      subsection: subsections[0],
      project: project
    }
  } + no_incentives_projects.map { |project|
    {
      funds_amount: 178_200.0 / no_incentives_projects.length,
      year: 2019,
      subsection: subsections[1],
      project: project
    }
  } + no_incentives_projects.map { |project|
    {
      funds_amount: 445_500.0 / no_incentives_projects.length,
      year: 2019,
      subsection: subsections[2],
      project: project
    }
  }
)
puts '-- create incentived project_funds_details'
incentives_pfds = ProjectFundsDetail.create!(
  incentives_projects.map { |project|
    {
      funds_amount: 250_800.0 / incentives_projects.length,
      year: 2019,
      subsection: subsections[0],
      project: project
    }
  } + incentives_projects.map { |project|
    {
      funds_amount: 167_200.0 / incentives_projects.length,
      year: 2019,
      subsection: subsections[1],
      project: project
    }
  } + incentives_projects.map { |project|
    {
      funds_amount: 418_000.0 / incentives_projects.length,
      year: 2019,
      subsection: subsections[2],
      project: project
    }
  }
)

puts '-- create funds_resolutions'
funds_resolution = FundsResolution.create! [{
  number: '241/2019',
  date: '2019-04-05',
  resolution_type: funds_resolution
}]

puts '-- create funds_destinations'
FundsDestination.create! [
  {
    name: 'Secretaría de Ciencia, Tecnología y Posgrado - Proyectos de I&D+i sin incentivo',
    project_funds_details: no_incentives_pfds,
    funds_resolution: funds_resolution.first
  },
  {
    name: 'Secretaría de Ciencia, Tecnología y Posgrado - Proyectos de I&D+i con incentivo',
    project_funds_details: incentives_pfds,
    funds_resolution: funds_resolution.first
  }
]

puts '-- create order_types'
OrderType.create! [
  {
    name_type_order: 'Solicitud de Elementos',
    order_type_attributes_attributes: [{ attribute_name: 'Rubro', attribute_type: 'Texto' }],
    order_detail_attributes_attributes: [
      { attribute_name: 'Código',   attribute_type: 'Texto' },
      { attribute_name: 'Cantidad', attribute_type: 'Número entero' }
    ]
  },
  {
    name_type_order: 'Solicitud de Reintegro',
    order_type_attributes_attributes: [
      { attribute_name: 'Fecha de gasto efectuado',            attribute_type: 'Fecha' },
      { attribute_name: 'Gasto (asistencia / viaje / compra)', attribute_type: 'Texto' },
      { attribute_name: 'Nombre completo del beneficiario',    attribute_type: 'Texto' },
      { attribute_name: 'Legajo del beneficiario',             attribute_type: 'Número entero' },
      { attribute_name: 'DNI del beneficiario',                attribute_type: 'Número entero' }
    ],
    order_detail_attributes_attributes: [
      { attribute_name: 'Fecha del comprobante',           attribute_type: 'Fecha' },
      { attribute_name: 'Número del comprobante',          attribute_type: 'Texto' },
      { attribute_name: 'Tipo del comprobante (B o C)',    attribute_type: 'Texto' },
      { attribute_name: 'Número de folio del comprobante', attribute_type: 'Número entero' }
    ]
  },
  {
    name_type_order: 'Solicitud de Viáticos',
    order_type_attributes_attributes: [
      { attribute_name: 'Tipo de viático (asistencia/viaje)', attribute_type: 'Texto' },
      { attribute_name: 'Fecha desde',                        attribute_type: 'Fecha' },
      { attribute_name: 'Fecha hasta',                        attribute_type: 'Fecha' }
    ],
    order_detail_attributes_attributes: [
      { attribute_name: 'Nombre del beneficiario', attribute_type: 'Texto' },
      { attribute_name: 'DNI del beneficiario',    attribute_type: 'Número entero' },
      { attribute_name: 'Origen',                  attribute_type: 'Texto' },
      { attribute_name: 'Destino',                 attribute_type: 'Texto' },
      { attribute_name: 'Fecha desde',             attribute_type: 'Fecha' },
      { attribute_name: 'Fecha hasta',             attribute_type: 'Fecha' }
    ]
  },
  {
    name_type_order: 'Solicitud de Pago Anticipado',
    order_type_attributes_attributes: [
      { attribute_name: 'Destino del pago', attribute_type: 'Texto' },
      { attribute_name: 'Fecha desde',      attribute_type: 'Fecha' },
      { attribute_name: 'Fecha hasta',      attribute_type: 'Fecha' }
    ],
    order_detail_attributes_attributes: [
      { attribute_name: 'Categoría',    attribute_type: 'Texto' },
      { attribute_name: 'Fecha límite', attribute_type: 'Fecha' }
    ]
  }
]

# AccessPermit
