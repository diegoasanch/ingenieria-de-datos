--------------------
---- Ejercicios ----
--------------------


-- 1. Mostrar todos los pacientes femeninos nacidos después del 2000

select *
    from pacientes
    where genero = 'F' and fecha_nacimiento >= '2000-01-01';


-- 2. Mostrar todos los médicos que no generaron ningún estudio
-- TODO: fix

select *
    from EspecialidadMedico
    inner join Medicos
    on EspecialidadMedico.id_medico = Medicos.id_medico
    inner join Especialidad
    on EspecialidadMedico.id_especialidad = Especialidad.id_especialidad
    where EspecialidadMedico.id_especialidad_medico not in
    (select id_especialidad_medico from Historial);



-- 3. Cual es la obra social que más afiliados tiene

select count(PP.id_plan) as Cantidad , PL.nombre, OO.sigla
    from Planes PL
    inner join PacientePlan PP
    on PL.id_planes = PP.id_plan
    inner join OOSS OO
    on PL.id_ooss = OO.id_ooss
    group by PP.id_plan, PL.nombre, OO.sigla
    having count(PP.id_plan) >= all (
        select count(PP.id_plan) as Cantidad
        from PacientePlan PP
        group by PP.id_plan
    );



-- 4. Cual es la edad media de los pacientes

select sum(edad) / count(*) from (
    select datediff(year, fecha_nacimiento, getdate()) as edad from Pacientes
) as edad;


-- 5. Cual es el instituto que hizo más estudios del ""

declare @NOMBRE_ESTUDIO as varchar(100) = 'Checkeo rutina'

select count(EST.nombre), INS.nombre nombre_ins, EST.nombre nombre_est
    from Estudio EST
    inner join Historial HIS on EST.id_estudio = HIS.id_estudio
    inner join Institutos INS on HIS.id_instituto = INS.id_institutos
    where EST.nombre = @NOMBRE_ESTUDIO
    group by INS.nombre, EST.nombre
    having count(EST.nombre) >= ALL (
        select count(EST.nombre)
            from Estudio EST
            inner join Historial HIS on EST.id_estudio = HIS.id_estudio
            inner join Institutos INS on HIS.id_instituto = INS.id_institutos
            group by INS.nombre, EST.nombre
    );


-- 6. Cual es el medico que indicó la mayor cantidad de estudios del Instituto X

select MED.id_medico, MED.nombre, count(HIS.id_historial) count_historial, HIS.id_instituto
    from Medicos MED
    left join EspecialidadMedico ESME on MED.id_medico = ESME.id_medico
    left join Historial HIS on ESME.id_especialidad_medico = HIS.id_especialiad_medico
    group by MED.id_medico, MED.nombre, HIS.id_instituto
    having HIS.id_instituto = 1 and count(HIS.id_historial) >= all (
        select count(HIS.id_historial)
            from Medicos MED
            left join EspecialidadMedico ESME on MED.id_medico = ESME.id_medico
            left join Historial HIS on ESME.id_especialidad_medico = HIS.id_especialiad_medico
            group by MED.id_medico, MED.nombre, HIS.id_instituto
    );


-- 7. Cual es el estudio que más se realiza

select EST.nombre, count(HIS.id_estudio) cant
    from Historial HIS
    left join Estudio EST on EST.id_estudio = HIS.id_estudio
    group by EST.id_estudio, EST.nombre
    having count(HIS.id_estudio) >= all (
        select count(HIS.id_estudio)
            from Historial HIS
            group by HIS.id_estudio1
    );


-- 8. Cual es el plan de OSDE que tiene más afiliados

declare @OBRA_SOCIAL as varchar(20) = 'OSDE'

select PL.id_planes id_plan, PL.nombre, count(PP.id_paciente) cant_afiliados
    from OOSS OS
    inner join Planes PL on PL.id_ooss = OS.id_ooss
    inner join PacientePlan PP on PP.id_plan = PL.id_planes
    where OS.sigla = @OBRA_SOCIAL
    group by PL.id_planes, PL.nombre
    having count(PP.id_paciente) >= all (
        select count(PP.id_paciente)
            from OOSS OS
            inner join Planes PL on PL.id_ooss = OS.id_ooss
            inner join PacientePlan PP on PP.id_plan = PL.id_planes
            where OS.sigla = @OBRA_SOCIAL
            group by PL.id_planes, PL.nombre
    );


-- 9. Cuales son las especialidades más requeridas por los pacientes

select ESP.id_especialidad, ESP.nombre, count(HIS.id_especialiad_medico) cant_historial
    from EspecialidadMedico ESPMED
    left join Historial HIS on HIS.id_especialiad_medico = ESPMED.id_especialidad_medico
    left join Especialidad ESP on ESP.id_especialidad = ESPMED.id_especialidad
    group by ESP.id_especialidad, ESP.nombre
    having count(HIS.id_especialiad_medico) >= all (
        select count(HIS.id_especialiad_medico)
            from EspecialidadMedico ESPMED
            left join Historial HIS on HIS.id_especialiad_medico = ESPMED.id_especialidad_medico
            group by ESPMED.id_especialidad
    );


-- 10. Cual es el estudio que más se realizó en el año X

declare @ANIO_ESTUDIO as varchar(4) = '2023'

select EST.id_estudio, EST.nombre, count(*) cant_estudios
    from Historial HIS
    left join Estudio EST on EST.id_estudio = HIS.id_estudio
    where year(fecha) = @ANIO_ESTUDIO
    group by EST.id_estudio, EST.nombre
    having count(*) >= all (
        select count(*)
            from Historial HIS
            where year(fecha) = @ANIO_ESTUDIO
            group by HIS.id_estudio
    );


-- 11.  Cual es el instituto que hizo más veces el estudio del punto 10

declare @ESTUDIO_ID as int = 1

select his.id_instituto, ins.nombre
	from Historial his
	left join Institutos ins on ins.id_institutos = his.id_instituto
	group by his.id_instituto, ins.nombre
	having count(*) >= all (
		select count(*) from Historial
			where id_estudio = @ESTUDIO_ID
			group by id_instituto
	);


-- 12. Cuantos pacientes nacidos antes de X se realizaron el estudio X

declare @FECHA_NAC as date = '2000-01-01'
declare @ESTUDIO_ID as int = 4

select count(distinct pac.id_paciente)
	from Historial his
	left join Pacientes pac on pac.id_paciente = his.id_paciente
	where his.id_estudio = @ESTUDIO_ID
	and pac.fecha_nacimiento < @FECHA_NAC;


