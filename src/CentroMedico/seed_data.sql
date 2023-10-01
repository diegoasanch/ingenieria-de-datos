----------------------------------
------- Inserting Data
----------------------------------

select * from Pacientes;

insert into Pacientes values
    ('Diego', 'Sanchez', 'm', '1999/01/18', '0x42069'),
    ('Jose', 'Salas', 'm', '1992/11/19', '00001'),
    ('Marta', 'Bosques', 'f', '1999/12/05', '00002'),
    ('Andrea', 'Aldama', 'f', '1989/09/11', '00003'),
    ('Kurtis', 'Conner', 'm', '1993/05/04', '00004')
;


select * from OOSS;

insert into OOSS values
    ('OSDE'),
    ('UP'),
    ('OSECAC'),
    ('SANCOR')
;



select * from Especialidad;

insert into Especialidad values
    ('Anestesiologia'),
    ('Cardiologia'),
    ('Dermatologia'),
    ('Hematologia'),
    ('Neurologia'),
    ('Oncologia'),
    ('Pediatria')
;


select * from Medicos;

insert into Medicos values
    ('00001', 'Fernanda', 'Williams', 'f', 1),
    ('00002', 'Selena', 'Louro', 'f', 1),
    ('00003', 'Layla', 'Richani', 'f', 1),
    ('00004', 'Peter', 'Parker', 'm', 1),
    ('00005', 'Barry', 'Block', 'm', 1),
    ('00006', 'Carmen', 'Berzatto', 'm', 1)
;


select * from EspecialidadMedico;
insert into EspecialidadMedico values
    (1, 1),
    (2, 2),
    (1, 3),
    (4, 4),
    (4, 5),
    (2, 1),
    (3, 2),
    (5, 3),
    (2, 4),
    (5, 5)
;


insert into EspecialidadMedico values
    (4, 4);

select * from Planes;

insert into Planes values
    (1, 'Plan Medio', '1', 1),
    (1, 'Plan Total', '360', 1),
    (2, 'Plan Premium', '1000', 1),
    (2, 'Plan Basico', '500', 1),
    (2, 'Plan Max Ultra Pro', '5000', 1),
    (3, 'Plan Internacional', '1', 1),
    (3, 'Plan Local', '2', 0),
    (3, 'Plan Local Nuevo Mejorado', '3', 1)
;


select * from Estudio;

insert into Estudio values
    ('Checkeo rutina', 1),
    ('Cirugia', 1),
    ('Examen', 1),
    ('Endoscopia', 1),
    ('Limpieza', 1),
    ('Amputacion', 1)
;


select * from EstudioPlan;

insert into EstudioPlan values
    (1, 1, 80),
    (1, 2, 100),
    (1, 3, 100),
    (1, 4, 20),
    (1, 5, 5),
    (1, 6, 75.4),

    (2, 1, 80),
    (2, 2, 100),
    (2, 3, 100),
    (2, 4, 20),
    (2, 5, 5),
    (2, 6, 75.4),

    (3, 1, 80),
    (3, 2, 100),
    (3, 3, 100),
    (3, 4, 20),
    (3, 5, 5),
    (3, 6, 75.4),

    (4, 1, 80),
    (4, 2, 100),
    (4, 3, 100),
    (4, 4, 20),
    (4, 5, 5),
    (4, 6, 75.4),

    (5, 1, 80),
    (5, 2, 100),
    (5, 3, 100),
    (5, 4, 20),
    (5, 5, 5),
    (5, 6, 75.4)
;


select * from Institutos;

insert into Institutos values
    ('Hospital The Bear', 'Calle 69, 420', 1),
    ('Hospital Good Vibes', 'Haze Way, 3301', 1),
    ('Clinica All Good', 'Some St, 1234', 0),
    ('Instituto Medico Steve Jobs', 'Infinite Loop 1, Cupertino', 1),
    ('Theranos', 'SF', 0)
;


select * from PacientePlan;

insert into PacientePlan values
    (1, 1),
    (1, 2),
    (2, 8),
    (3, 3),
    (4, 5),
    (5, 6),
    (5, 4)
;


select * from Historial;
insert into Historial values
    ('2023/08/25', 1, 'Salio bien', 1, 8, 1, 2, 3, 4),
    ('2023/09/10', 0, null, 0, 3, 4, 1, 4, 4),
    ('2023/09/01', 1, 'Necesita otra consulta', 1, 2, 1, 2, 3, 1),
    ('2023/08/29', 1, 'Tiene covid', 1, 8, 2, 4, 1, 2),
    ('2023/09/05', 0, 'Deshidratacion', 0, 5, 4, 2, 5, 1)
;


insert into Historial values
    ('2023/08/25', 1, 'Salio bien', 1, 8, 1, 1002, 3, 1)
