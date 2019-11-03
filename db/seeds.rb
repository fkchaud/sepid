# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

SubsectionShiftStatus.create! [
  { name: 'Solicitado' },
  { name: 'Aprobado'   },
  { name: 'Rechazado'  }
]

Subsection.create! [
  { name: '2'   },
  { name: '3'   },
  { name: '4.3' }
]

ValueStatus.create! [
  { value_status_name: 'Estimado'   },
  { value_status_name: 'Preventivo' },
  { value_status_name: 'Final'      },
  { value_status_name: 'Cancelado'  },
  { value_status_name: 'Rechazado'  }
]

# carga segun resolucion 715/2018 de Rectorado
# http://csu.rec.utn.edu.ar/docs/php/salida_nuevo_sitio_rectorado.php3?tipo=RES&numero=715%anio=2018%facultad=CSU
UniversityPosition.create! [
  { name: 'Consejero Superior',            per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Jurado de Concurso Docente',    per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Jurado de Concurso Nodocente',  per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Autoridad de Rectorado',        per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Autoridad de Unidad Académica', per_travel_payment: 1800.0, per_lunch_payment: 360.0 },
  { name: 'Otros Cargos',                  per_travel_payment: 1560.0, per_lunch_payment: 360.0 }
]

ProjectType.create! [
  { name: 'PID', purpose: '03 - Servicios Sociales', function: '05 - Ciencia y Técnica',
    program: '18 - Investigación', activity: '02 - Investigación Aplicada',
    financing: '11 - Contribución del Tesoro' }
]
project_type_pid = ProjectType.find_by_name('PID')

ProjectStatus.create! [
  { name: 'Aprobado'     },
  { name: 'En ejecución' },
  { name: 'Finalizado'   },
  { name: 'Cancelado'    }
]
project_status_approved = ProjectStatus.find_by_name('Aprobado')

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

UserProfile.create! [
  { name: 'Investigador' },
  { name: 'Super_Admin'  },
  { name: 'DEF_Admin'    },
  { name: 'SeCYT_Sec'    },
  { name: 'SeCYT_Admin'  }
]

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
  }
]
user_bromberg = User.find_by_user_name('bromberg')
user_inv2 = User.find_by_user_name('investigador2')

no_incentives_codes = "UTN5007,UTN4508,UTN4544,UTN4623,INN3986,
UTN4564,IAN4037,IAN4940,UTN4046,UTN4343,IFN4491,UTN4450,
UTN4529,INN4556,UTN4455,UTN4624,UTN4063,UTN3965,IAN4514,
UTN4582,UTN4920,INN5014,UTN4092,UTN4625,UTN4528,UTN4805,
UTN4741".split(',')

no_incentives_projects = Project.create!(
  no_incentives_codes.map do |code|
    {
      project_code: code,
      project_name: "Project #{code}",
      start_date: '2018-01-01',
      ending_date: '2018-12-31',
      project_status: project_status_approved,
      project_type: project_type_pid,
      director: user_bromberg,
      codirector: user_inv2
    }
  end
)

incentives_codes = "UTI3601,UTI4481,UTI4368,INI3878,
OTI4087,UTI4335,UTI4404,UTI4523,UTI,4880,UTI4588,UTI4615,UTI4905,
INI4600,UTI4035,IFI3954; UTI4596,UTI4030,UTI4814,UTI4915,UTI4736,
UTI4413,UTI4034".split(',')

incentives_projects = Project.create!(
  incentives_codes.map do |code|
    {
      project_code: code,
      project_name: "Project #{code}",
      start_date: '2018-01-01',
      ending_date: '2018-12-31',
      project_status: project_status_approved,
      project_type: project_type_pid, # maybe change to pid with incentives in the future
      director: user_bromberg,
      codirector: user_inv2
    }
  end
)


# AccessPermit

# crear tipos de pedidos
