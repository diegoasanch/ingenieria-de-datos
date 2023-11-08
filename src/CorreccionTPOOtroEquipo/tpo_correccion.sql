-- Creacion de tablas

create table Entrenador (
	entrenador_id int not null primary key identity(1, 1),
	nombre varchar(255) not null,
	puntuacion int not null,
	equipo_id int not null,
	ciudad_origen int not null
);

create table Equipo (
	equipo_id int not null primary key identity(1, 1),
	lider_entrenador_id int not null,
	gimnasio_id int not null,
	estado int not null
);

create table Habilidad (
	habilidad_id int not null primary key identity(1, 1),
	nombre varchar(255) not null,
	tipo_de_danio varchar(255) not null,
	potencia int not null,
	precision_de_acierto int not null
);

create table Batalla (
	batalla_id int not null primary key identity(1, 1),
	ganador_id int not null,
	perdedor_id int not null,
	fecha datetime not null,
	gimnasio_id int not null
);

create table Ciudad (
	ciudad_id int not null primary key identity(1, 1),
	nombre varchar(255) not null,
);

create table Intercambio (
	interciambio_id int not null primary key identity(1, 1),
	origen_equipo_id int not null,
	destino_equipo_id int not null,
	pokemon_id int not null
);

create table Pokemon (
	pokemon_id int not null primary key identity(1, 1),
	nivel int not null,
	salud int not null,
	especie varchar(255) not null,
	nombre varchar(255) not null,
	tipo varchar(255) not null,
	equipo_id int not null
);

create table HabilidadPokemon (
	habilidad_pokemon_id int not null primary key identity(1, 1),
	pokemon_id int not null,
	habilidad_id int not null
);

create table Medalla (
	medalla_id int not null primary key identity(1, 1),
	nombre varchar(255) not null,
	gimnasio_id int not null
);

create table ObtencionMedalla (
	obtencion_medalla_id int not null primary key identity(1, 1),
	batalla_id int not null,
	equipo_id int not null
);

create table Captura (
	captura_id int not null primary key identity(1, 1),
	pokemon_id int not null,
	equipo_id int not null,
	batalla_id  int not null
);

create table Gimnasio (
	gimnasio_id int not null primary key identity(1, 1),
	ciudad_id int not null,
	nombre varchar(255) not null
);

-- Agregamos foreign keys

-- Entrenador
alter table Entrenador add constraint fk_entrenador_equipo foreign key (equipo_id) references Equipo(equipo_id);
alter table Entrenador add constraint fk_entrenador_ciudad foreign key (ciudad_origen) references Ciudad(ciudad_id);

-- Equipo
alter table Equipo add constraint fk_equipo_entrenador foreign key (lider_entrenador_id) references Entrenador(entrenador_id);
alter table Equipo add constraint fk_equipo_gimnasio foreign key (gimnasio_id) references Gimnasio(gimnasio_id);

-- Batalla
alter table Batalla add constraint fk_batalla_ganador foreign key (ganador_id) references Equipo(equipo_id);
alter table Batalla add constraint fk_batalla_perdedor foreign key (perdedor_id) references Equipo(equipo_id);
alter table Batalla add constraint fk_batalla_gimnasio foreign key (gimnasio_id) references Gimnasio(gimnasio_id);

-- Gimnasio
alter table Gimnasio add constraint fk_gimnasio_ciudad foreign key (ciudad_id) references Ciudad(ciudad_id);

-- Intercambio
alter table Intercambio add constraint fk_intercambio_origen_equipo foreign key (origen_equipo_id) references Equipo(equipo_id);
alter table Intercambio add constraint fk_intercambio_destino_equipo foreign key (destino_equipo_id) references Equipo(equipo_id);
alter table Intercambio add constraint fk_intercambio_pokemon foreign key (pokemon_id) references Pokemon(pokemon_id);

-- Pokemon
alter table Pokemon add constraint fk_pokemon_equipo foreign key (equipo_id) references Equipo(equipo_id);

-- HabilidadPokemon
alter table HabilidadPokemon add constraint fk_habilidadpokemon_pokemon foreign key (pokemon_id) references Pokemon(pokemon_id);
alter table HabilidadPokemon add constraint fk_habilidadpokemon_habilidad foreign key (habilidad_id) references Habilidad(habilidad_id);

-- Medalla
alter table Medalla add constraint fk_medalla_gimnasio foreign key (gimnasio_id) references Gimnasio(gimnasio_id);

-- ObtencionMedalla
alter table ObtencionMedalla add constraint fk_obtencionmedalla_batalla foreign key (batalla_id) references Batalla(batalla_id);
alter table ObtencionMedalla add constraint fk_obtencionmedalla_equipo foreign key (equipo_id) references Equipo(equipo_id);

-- Captura
alter table Captura add constraint fk_captura_pokemon foreign key (pokemon_id) references Pokemon(pokemon_id);
alter table Captura add constraint fk_captura_equipo foreign key (equipo_id) references Equipo(equipo_id);
alter table Captura add constraint fk_captura_batalla foreign key (batalla_id) references Batalla(batalla_id);
