SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;
SELECT nombre,apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;
SELECT * FROM personadepartamentodepartamento WHERE fecha_nacimiento LIKE '%1991%';
SELECT * FROM persona WHERE nif LIKE '%k' AND telefono IS NULL AND tipo = 'profesor';
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND id_grado = 7 AND curso = 3;
SELECT apellido1, apellido2, persona.nombre, departamento.nombre FROM persona JOIN profesor ON id_profesor = id JOIN departamento ON id_departamento = departamento.id ORDER BY apellido1, persona.nombre;
SELECT persona.apellido1, persona.nombre, asignatura.nombre, anyo_inicio, anyo_fin FROM alumno_se_matricula_asignatura  JOIN asignatura ON id_asignatura = id  JOIN curso_escolar ON id_curso_escolar = curso_escolar.id JOIN persona ON id_alumno = persona.id WHERE nif = '26902806M';
SELECT DISTINCT departamento.nombre FROM grado JOIN asignatura ON grado.id = asignatura.id_grado JOIN profesor ON profesor.id_profesor = asignatura.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
SELECT DISTINCT apellido1, apellido2, persona.nombre FROM persona JOIN alumno_se_matricula_asignatura ON id_alumno = id WHERE id_curso_escolar = 5;



SELECT * FROM alumno_se_matricula_asignatura;
SELECT * FROM persona;
SELECT * FROM curso_escolar;
SELECT * FROM asignatura;
SELECT * FROM departamento;
SELECT * FROM grado;
SELECT * FROM profesor;