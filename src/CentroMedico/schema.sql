create database "CENTRO_MEDICO_2";

-- OBRA SOCIAL

create table OOSS (
    id_ooss int identity(1,1),
    sigla varchar(50) not null,

    constraint pk_ooss primary key (id_ooss)
);


-- Especialidad

create table Especialidad (
    id_especialidad int identity(1, 1),
    nombre varchar(100),

    constraint pk_especialidad primary key (id_especialidad)
);

-- Medicos

create table Medicos (
    id_medico int identity(1, 1),
    matricula varchar(50),
    nombre varchar(100),
    apellido varchar(100),
    genero char(1),
    activo bit not null,

    constraint pk_medicos primary key (id_medico),
    constraint check_genero check (genero in ('f', 'm', 'o', 'x'))
);

-- EspecialidadMedico

create table EspecialidadMedico (
    id_especialidad_medico int identity(1, 1),
    id_especialidad int not null,
    id_medico int not null,

    constraint pk_especialidad_medico primary key (id_especialidad_medico),
    constraint fk_especialidad_medico_especialidad foreign key (id_especialidad) references Especialidad,
    constraint fk_especialidad_medico_medico foreign key (id_medico) references Medicos

);


-- Planes

create table Planes (
    id_planes int identity(1, 1),
    id_ooss int not null,
    nombre varchar(100),
    numero_plan varchar(50),
    activo bit not null,

    constraint pk_planes primary key (id_planes),
    constraint fk_plan_ooss foreign key (id_ooss) references OOSS,
);


-- Estudio

create table Estudio (
    id_estudio int identity(1, 1),
    nombre varchar(100),
    activo bit not null,

    constraint pk_estudio primary key (id_estudio),
);

-- EstudioPlan

create table EstudioPlan (
    id_estudio_plan int identity(1, 1),
    id_planes int not null,
    id_estudio int not null,
    porcentaje float not null,

    constraint pk_estudio_plan primary key (id_estudio_plan),
    constraint fk_estudio_plan_plan foreign key (id_planes) references Planes,
    constraint fk_estudio_plan_estudio foreign key (id_estudio) references Estudio
);

-- Institutos

create table Institutos (
    id_institutos int identity(1, 1),
    nombre varchar(100),
    direccion varchar(200),
    activo bit not null,

    constraint pk_institutos primary key (id_institutos)
);

-- Pacientes

create table Pacientes (
    id_paciente int identity(1, 1),
    nombre varchar(100),
    apellido varchar(100),
    genero char(1),
    fecha_nacimiento date,
    numero_afiliado varchar(50),

    constraint pk_pacientes primary key (id_paciente),
    constraint check_paciente_genero check (genero in ('f', 'm', 'o', 'x')),
    constraint check_paciente_nacimiento check (
        fecha_nacimiento >= '1900-01-01' and fecha_nacimiento <= GETDATE()
    ),
    constraint unique_numero_afiliado unique (numero_afiliado)

);


-- PacientePlan

create table PacientePlan (
    id_paciente_plan int identity(1, 1),
    id_paciente int not null,
    id_plan int not null,

    constraint pk_paciente_plan primary key (id_paciente_plan),
    constraint fk_paciente_plan_paciente foreign key (id_paciente) references Pacientes,
    constraint fk_paciente_plan_plan foreign key (id_plan) references Planes,
);

-- Historial

create table Historial (
    id_historial int identity(1, 1),
    fecha date,
    pagado bit,
    resultado varchar(1000),
    copago bit,

    id_plan int not null,
    id_estudio int not null,
    id_especialiad_medico int not null,
    id_paciente int not null,
    id_instituto int not null,

    constraint pk_historial primary key (id_historial),

    constraint fk_historial_plan foreign key (id_plan) references Planes,
    constraint fk_historial_estudio foreign key (id_estudio) references Estudio,
    constraint fk_historial_especialidad_medico foreign key (id_especialiad_medico) references EspecialidadMedico,
    constraint fk_historial_paciente foreign key (id_paciente) references Pacientes,
    constraint fk_historial_instituto foreign key (id_instituto) references Institutos,

    constraint check_historial_fecha check (
        fecha >= DATEADD(month, -1, GETDATE()) and
        fecha <= DATEADD(month, 1, GETDATE())
    )
);


