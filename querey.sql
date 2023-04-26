-- Active: 1682518579114@@127.0.0.1@5432@udenardb@public

SELECT * from barrios;

--Actualizar nota final y estado  en regnotas

-- sql

update regnotas
set
    nfinal = parcial1 * 0.30 + parcial2 * 0.30 + efinal * 0.40;

--estado

update regnotas set estado = 'A' where nfinal>= 3.0;

update regnotas set estado = 'R' where nfinal< 3.0;

-----------------------------------------------------------------------------------------

-- Operaciones COn conjuntos

-----------------------------------------------------------------------------------------

--Operación Unión. Es una operación binaria que toma dos relaciones union compatibes y prouciendo una nueva con el esquema de la primera

-- y con la union de las tuplas de la primera y segunda relación, eliminando los duplicados

--Dos relaciones son union compatibles cuando tienen el mismo grado (el mismo numero de atributos)

--y el tipo de cada atributo de la primera relación es igual es igual al tipo de cada atributo respectivo de la segunda relación

--La union es una operación conmutativa

--Se implemeta en sql con la clausula UNION

--Si dos relaciones no son union compatibles, sus proyecciones si lo pueden ser

-------------------------------------------------------------------------------------------

--Crear la tabla pastusos y paisas

CREATE Table pastusos as
select
    codestudiante as codpas,
    nomestudiante as nompas,
    sexestudiante as sexpas,
    edaestudiante as edapas,
    nommunicipio as ciupas,
    nomprograma as progpas
from estudiantes
    join municipios on ciudad = codmunicipio
    join programas on programa = codprograma
where
    trim(lower(nommunicipio)) like '%pasto%';

select * from pastusos;

CREATE Table paisas as
select
    codestudiante as codpai,
    nomestudiante as nompai,
    sexestudiante as sexpai,
    edaestudiante as edapai,
    nommunicipio as ciupai,
    nomprograma as progpai
from estudiantes
    join municipios on ciudad = codmunicipio
    join programas on programa = codprograma
where
    trim(lower(nommunicipio)) like '%medell_%';

select * from paisas;

-------------------------------------------------------------------------

--visualizar los pastusos y paisas del programa de ingenieria de sistemas

select *
from pastusos
WHERE progpas LIKE '%istem%'
UNION
SELECT *
from paisas
WHERE progpai LIKE '%istem%'
order by edapas;

--la UNION es conmutativa

select *
from paisas
WHERE progpai LIKE '%istem%'
UNION
SELECT *
from pastusos
WHERE progpas LIKE '%istem%'
order by edapai;

---------------------------------------------------------------------

--Union con varias relaciones con proyecciones y restricciones

---------------------------------------------------------------------

--Visualizar los pastusos, paisas , rolos y caleños

-- del programa de ingenieria de sistemas

--cuya edad esta entre 18 y 20 años

--ordenados por sexo y edad descendente

---------------------------------------------------------------------

SELECT
    nompas,
    sexpas,
    edapas,
    ciupas,
    progpas
from pastusos
WHERE
    progpas LIKE '%istem%'
    AND edapas BETWEEN 18 AND 20
UNION
SELECT
    nompai,
    sexpai,
    edapai,
    ciupai,
    progpai
from paisas
WHERE
    progpai LIKE '%istem%'
    AND edapai BETWEEN 18 AND 20
UNION
SELECT
    nomestudiante,
    sexestudiante,
    edaestudiante,
    nommunicipio,
    nomprograma
from estudiantes
    JOIN municipios on ciudad = codmunicipio
    JOIN programas on programa = codprograma
WHERE
    nomprograma like '%istem%'
    and edaestudiante BETWEEN 18 and 20
    and trim(lower(nommunicipio)) like '%ogt_%'
UNION
SELECT
    nomestudiante,
    sexestudiante,
    edaestudiante,
    nommunicipio,
    nomprograma
from estudiantes
    JOIN municipios on ciudad = codmunicipio
    JOIN programas on programa = codprograma
WHERE
    nomprograma like '%istem%'
    and edaestudiante BETWEEN 18 and 20
    and trim(lower(nommunicipio)) like '%cal%'
ORDER BY 2, 3;

--Eliminando duplicados

--visualizar la edad, sexo y ciudad de los pastusos y paisas

--ordenados por ciudad

SELECT edapas, sexpas, ciupas
from pastusos
UNION
SELECT edapai, sexpai, ciupai
from paisas
order by 3;

--Sin eliminar duplicados

SELECT edapas, sexpas, ciupas
from pastusos
UNION ALL
SELECT edapai, sexpai, ciupai
from paisas
order by 3, 2, 1;

/*
 INTERSECCIONES
 Una operación binaria que toma dos relaciones compatibles y produce una nueva
 con el esquema de la primera y con las tuplas comunes de la primera y segunda
 relación eliminando duplicados
 */

--visualizar las estudiantes de ingenieria de sistemas que matricularon

-- a la vez bases de datos e introducción a la programación

--ordenados por edad

--Si mostramos el nombre de la materia no los hace comunes y no sale ninguno

select
    nomestudiante,
    sexestudiante,
    edaestudiante,
    nomprograma
from estudiantes
    join programas on programa = codprograma
    join regnotas on codestudiante = estudiante
    join materias on materia = codmateria
WHERE
    sexestudiante = 'F'
    and nomprograma like '%istem%'
    and lower(nommateria) like '%ase%atos%'
INTERSECT
select
    nomestudiante,
    sexestudiante,
    edaestudiante,
    nomprograma
from estudiantes
    join programas on programa = codprograma
    join regnotas on codestudiante = estudiante
    join materias on materia = codmateria
WHERE
    sexestudiante = 'F'
    and nomprograma like '%istem%'
    and lower(nommateria) like '%troducc%prog%';

/*
 Diferencia: 
 Es una operación binaria que toma dos relaciones 
 union compatibles y produce una nueva con un esquema de la primera
 y las tuplas de la primera que no estan en la segunda,
 eliminando duplicados.
 Se implementa en postgress  con EXCEPT (en oracle con MINUS)
 Esto no es conmutativo
 */

--visualizar las estudiantes de ingenieria de sistemas que matricularon

-- bases de datos  pero no introducción a la programación

--ordenados por edad

select
    nomestudiante,
    sexestudiante,
    edaestudiante,
    nomprograma
from estudiantes
    join programas on programa = codprograma
    join regnotas on codestudiante = estudiante
    join materias on materia = codmateria
WHERE
    sexestudiante = 'F'
    and nomprograma like '%istem%'
    and lower(nommateria) like '%ase%atos%'
EXCEPT
select
    nomestudiante,
    sexestudiante,
    edaestudiante,
    nomprograma
from estudiantes
    join programas on programa = codprograma
    join regnotas on codestudiante = estudiante
    join materias on materia = codmateria
WHERE
    sexestudiante = 'F'
    and nomprograma like '%istem%'
    and lower(nommateria) like '%troducc%prog%';

--visualizar las estudiantes de ingenieria de sistemas que matricularon

-- introducción a la programación pero no bases de datos introducción a la programación

--ordenados por edad

select
    nomestudiante,
    sexestudiante,
    edaestudiante,
    nomprograma
from estudiantes
    join programas on programa = codprograma
    join regnotas on codestudiante = estudiante
    join materias on materia = codmateria
WHERE
    sexestudiante = 'F'
    and nomprograma like '%istem%'
    and lower(nommateria) like '%troducc%prog%'
EXCEPT
select
    nomestudiante,
    sexestudiante,
    edaestudiante,
    nomprograma
from estudiantes
    join programas on programa = codprograma
    join regnotas on codestudiante = estudiante
    join materias on materia = codmateria
WHERE
    sexestudiante = 'F'
    and nomprograma like '%istem%'
    and lower(nommateria) like '%ase%atos%';

/*
 Consultas con UNION, INTERSECT y EXCEPT
 */

--visualizar los estudiantes de Pasto, de ingenieria de sistemas

--que matriccularon bases de datos o calculo diferencial y a la vez

-- introducción a la programación, pero que no matricularon inroduccion a la ingenieria de sistemas

-- ordenados por sexo

--Siempre se hace primero el INTERSECT por eso se debe porner la UNION en parentecis

(
    SELECT
        nomestudiante,
        sexestudiante,
        edaestudiante,
        nommunicipio,
        nomprograma
    from estudiantes
        JOIN municipios on ciudad = codmunicipio
        JOIN programas on programa = codprograma
        join regnotas on codestudiante = estudiante
        join materias on materia = codmateria
    WHERE
        lower(nommunicipio) like '%pasto%'
        and nomprograma like '%istem%'
        AND nommateria LIKE '%ase%atos%'
    UNION
    SELECT
        nomestudiante,
        sexestudiante,
        edaestudiante,
        nommunicipio,
        nomprograma
    from estudiantes
        JOIN municipios on ciudad = codmunicipio
        JOIN programas on programa = codprograma
        join regnotas on codestudiante = estudiante
        join materias on materia = codmateria
    WHERE
        lower(nommunicipio) like '%pasto%'
        and nomprograma like '%istem%'
        AND nommateria LIKE '%cul%feren%'
)
INTERSECT
SELECT
    nomestudiante,
    sexestudiante,
    edaestudiante,
    nommunicipio,
    nomprograma
from estudiantes
    JOIN municipios on ciudad = codmunicipio
    JOIN programas on programa = codprograma
    join regnotas on codestudiante = estudiante
    join materias on materia = codmateria
WHERE
    lower(nommunicipio) like '%pasto%'
    and nomprograma like '%istem%'
    AND nommateria LIKE '%tro%gram%'
EXCEPT
SELECT
    nomestudiante,
    sexestudiante,
    edaestudiante,
    nommunicipio,
    nomprograma
from estudiantes
    JOIN municipios on ciudad = codmunicipio
    JOIN programas on programa = codprograma
    join regnotas on codestudiante = estudiante
    join materias on materia = codmateria
WHERE
    lower(nommunicipio) like '%pasto%'
    and nomprograma like '%istem%'
    AND nommateria LIKE '%tro%stem%'
ORDER BY 2;