
-- 1. Mostrar todos los pacientes femeninos nacidos después del 2000
create procedure SP_OBTENER_PACIENTES_FEM
    @Genero char(1)
as
begin
    select *
        from pacientes
        where genero = @Genero and fecha_nacimiento >= '2000-01-01'
end;

exec SP_OBTENER_PACIENTES_FEM 'M';
go;


-- 2. Mostrar todos los médicos que no generaron ningún estudio
create procedure SP_OBTENER_MEDICOS_SIN_ESTUDIOS
as
begin
    select med.id_medico, med.nombre
        from Medicos med
        where med.id_medico not in (
            select distinct espemed.id_medico
                from Historial his
                left join EspecialidadMedico espemed on espemed.id_especialidad_medico = his.id_especialiad_medico
        )
        group by med.id_medico, med.nombre
end;

EXEC SP_OBTENER_MEDICOS_SIN_ESTUDIOS;
go;

-- 3. Cual es la obra social que más afiliados tiene

create PROCEDURE SP_OBRA_SOCIAL_MAS_AFILIADA
as
begin
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
        )
end;

EXEC SP_OBRA_SOCIAL_MAS_AFILIADA;
go;


-- 4. Cual es la edad media de los pacientes

create procedure SP_EDAD_MEDIA_PACIENTES
as
begin
    select sum(edad) / count(*) from (
        select datediff(year, fecha_nacimiento, getdate()) as edad from Pacientes
    ) as edad
end;

exec SP_EDAD_MEDIA_PACIENTES;
go;

-- 5. Cual es el instituto que hizo más estudios del ""

create procedure SP_INSTITUTO_CON_MAS_ESTUDIOS_10
    @NOMBRE_ESTUDIO varchar(100)
as
begin
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
end;

exec SP_INSTITUTO_CON_MAS_ESTUDIOS 'Checkeo rutina';
go;



-- 6. Cual es el medico que indicó la mayor cantidad de estudios del Instituto X

create procedure SP_MEDICO_CON_MAS_ESTUDIOS
    @ID_INSTITUTO int
as
begin
    select MED.id_medico, MED.nombre, count(HIS.id_historial) count_historial, HIS.id_instituto
        from Medicos MED
        left join EspecialidadMedico ESME on MED.id_medico = ESME.id_medico
        left join Historial HIS on ESME.id_especialidad_medico = HIS.id_especialiad_medico
        group by MED.id_medico, MED.nombre, HIS.id_instituto
        having HIS.id_instituto = @ID_INSTITUTO and count(HIS.id_historial) >= all (
            select count(HIS.id_historial)
                from Medicos MED
                left join EspecialidadMedico ESME on MED.id_medico = ESME.id_medico
                left join Historial HIS on ESME.id_especialidad_medico = HIS.id_especialiad_medico
                group by MED.id_medico, MED.nombre, HIS.id_instituto
        )
end;

exec SP_MEDICO_CON_MAS_ESTUDIOS 1;
go;




-- 7. Cual es el estudio que más se realiza

CREATE PROCEDURE SP_ESTUDIO_MAS_REALIZADO
as
begin
    select EST.nombre, count(HIS.id_estudio) cant
        from Historial HIS
        left join Estudio EST on EST.id_estudio = HIS.id_estudio
        group by EST.id_estudio, EST.nombre
        having count(HIS.id_estudio) >= all (
            select count(HIS.id_estudio)
                from Historial HIS
                group by HIS.id_estudio
        )
end;

exec SP_ESTUDIO_MAS_REALIZADO;
go;




-- 8. Cual es el plan de OSDE que tiene más afiliados

create procedure SP_PLAN_OBRA_SOCIAL_MAS_AFILIADA
    @OBRA_SOCIAL varchar(20)
as
begin
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
        )
END;

exec SP_PLAN_OBRA_SOCIAL_MAS_AFILIADA 'OSDE';
GO;


-- 9. Cuales son las especialidades más requeridas por los pacientes

create procedure SP_ESPECIALIDADES_MAS_REQUERIDAS
as
begin
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
        )
END;

exec SP_ESPECIALIDADES_MAS_REQUERIDAS;
go;


-- 10. Cual es el estudio que más se realizó en el año X


create procedure SP_ESTUDIO_MAS_REALIZADO_ANIO
    @ANIO_ESTUDIO varchar(4)
as
begin
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
        )
end;

exec SP_ESTUDIO_MAS_REALIZADO_ANIO '2023';
go;


-- 11.  Cual es el instituto que hizo más veces el estudio del punto 10


create procedure SP_INSTITUTO_CON_MAS_ESTUDIOS_10
    @ESTUDIO_ID int
as
begin
    select his.id_instituto, ins.nombre
        from Historial his
        left join Institutos ins on ins.id_institutos = his.id_instituto
        group by his.id_instituto, ins.nombre
        having count(*) >= all (
            select count(*) from Historial
                where id_estudio = @ESTUDIO_ID
                group by id_instituto
        )
end;

exec SP_INSTITUTO_CON_MAS_ESTUDIOS_10 1;
go;


-- 12. Cuantos pacientes nacidos antes de X se realizaron el estudio X

create procedure SP_PACIENTES_NACIDOS_ANTES_DE_FECHA
    @FECHA_NAC date,
    @ESTUDIO_ID int
as
begin
    select count(distinct pac.id_paciente)
        from Historial his
        left join Pacientes pac on pac.id_paciente = his.id_paciente
        where his.id_estudio = @ESTUDIO_ID
        and pac.fecha_nacimiento < @FECHA_NAC
end;

exec SP_PACIENTES_NACIDOS_ANTES_DE_FECHA '2000-01-01', 4;
