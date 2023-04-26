-- ==========================================================
--- tabla sbr11_narino
-- ==========================================================
create table sbr11_narino
(
ESTU_TIPODOCUMENTO text,
ESTU_NACIONALIDAD text,
ESTU_GENERO text,
ESTU_FECHANACIMIENTO text,
PERIODO text,
ESTU_CONSECUTIVO text,
ESTU_ESTUDIANTE text,
ESTU_PAIS_RESIDE text,
ESTU_TIENEETNIA text,
ESTU_ETNIA text,
ESTU_LIMITA_MOTRIZ text,
ESTU_DEPTO_RESIDE text,
ESTU_COD_RESIDE_DEPTO text,
ESTU_MCPIO_RESIDE text,
ESTU_COD_RESIDE_MCPIO text,
FAMI_ESTRATOVIVIENDA text,
FAMI_PERSONASHOGAR text,
FAMI_CUARTOSHOGAR text,
FAMI_EDUCACIONPADRE text,
FAMI_EDUCACIONMADRE text,
FAMI_TRABAJOLABORPADRE text,
FAMI_TRABAJOLABORMADRE text,
FAMI_TIENEINTERNET text,
FAMI_TIENESERVICIOTV text,
FAMI_TIENECOMPUTADOR text,
FAMI_TIENELAVADORA text,
FAMI_TIENEHORNOMICROOGAS text,
FAMI_TIENEAUTOMOVIL text,
FAMI_TIENEMOTOCICLETA text,
FAMI_TIENECONSOLAVIDEOJUEGOS text,
FAMI_NUMLIBROS text,
FAMI_COMELECHEDERIVADOS text,
FAMI_COMECARNEPESCADOHUEVO text,
FAMI_COMECEREALFRUTOSLEGUMBRE text,
FAMI_SITUACIONECONOMICA text,
ESTU_DEDICACIONLECTURADIARIA text,
ESTU_DEDICACIONINTERNET text,
ESTU_HORASSEMANATRABAJA text,
ESTU_TIPOREMUNERACION text,
COLE_CODIGO_ICFES text,
COLE_COD_DANE_ESTABLECIMIENTO text,
COLE_NOMBRE_ESTABLECIMIENTO text,
COLE_GENERO text,
COLE_NATURALEZA text,
COLE_CALENDARIO text,
COLE_BILINGUE text,
COLE_CARACTER text,
COLE_COD_DANE_SEDE text,
COLE_NOMBRE_SEDE text,
COLE_SEDE_PRINCIPAL text,
COLE_AREA_UBICACION text,
COLE_JORNADA text,
COLE_COD_MCPIO_UBICACION text,
COLE_MCPIO_UBICACION text,
COLE_COD_DEPTO_UBICACION text,
COLE_DEPTO_UBICACION text,
ESTU_PRIVADO_LIBERTAD text,
ESTU_COD_MCPIO_PRESENTACION text,
ESTU_MCPIO_PRESENTACION text,
ESTU_DEPTO_PRESENTACION text,
ESTU_COD_DEPTO_PRESENTACION text,
PUNT_LECTURA_CRITICA text,
PERCENTIL_LECTURA_CRITICA text,
DESEMP_LECTURA_CRITICA text,
PUNT_MATEMATICAS text,
PERCENTIL_MATEMATICAS text,
DESEMP_MATEMATICAS text,
PUNT_C_NATURALES text,
PERCENTIL_C_NATURALES text,
DESEMP_C_NATURALES text,
PUNT_SOCIALES_CIUDADANAS text,
PERCENTIL_SOCIALES_CIUDADANAS text,
DESEMP_SOCIALES_CIUDADANAS text,
PUNT_INGLES text,
PERCENTIL_INGLES text,
DESEMP_INGLES text,
PUNT_GLOBAL text,
PERCENTIL_GLOBAL text,
ESTU_NSE_ESTABLECIMIENTO text,
ESTU_INSE_INDIVIDUAL text,
ESTU_NSE_INDIVIDUAL text,
ESTU_ESTADOINVESTIGACION text,
ESTU_GENERACIONE text
);
-------------------------------------------------------------------------------------
-- poblar tabla a partir de archivo plano
-------------------------------------------------------------------------------------
copy sbr11_narino from 'D:\sbr11_narino.csv'
with (delimiter '|',format 'csv',encoding 'UTF-8',header);
--COPY 549934
--Query returned successfully in 11 secs 234 msec.
select * from sbr11_narino limit 100;

select count (*) from sbr11_narino;
select count (ESTU_TIENEETNIA) from sbr11_narino;
select count (ESTU_LIMITA_MOTRIZ) from sbr11_narino;
select count () from sbr11_narino;
select count () from sbr11_narino;
select count () from sbr11_narino;
select count () from sbr11_narino;
select count () from sbr11_narino;


----------------------------------------------------------------------------------
-- CREAR LA TABLA SBR11_NARINO_182
-----------------------------------------------------------------------------------
create table sbr11_narino_182 as
select * from sbr11_20182 where estu_depto_reside like 'NARI_O'
-- SELECT 17205
-- Query returned successfully in 513 msec.
-----------------------------------------------------------------------------------












