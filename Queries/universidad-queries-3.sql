SELECT COUNT(*) FROM persona WHERE tipo = 'alumno';
SELECT COUNT(*) FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento LIKE '%1999%';
SELECT COUNT(id_profesor) AS 'profesors', departamento.nombre FROM profesor JOIN departamento ON departamento.id = profesor.id_departamento GROUP BY id_departamento ORDER BY profesors DESC;
SELECT departamento.nombre, COUNT(id_profesor) FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre;
SELECT grado.nombre, COUNT(asignatura.nombre) AS 'num asignatures' FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY 2 DESC;
SELECT grado.nombre, COUNT(asignatura.nombre) AS 'num asignatures' FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado group by grado.nombre HAVING COUNT(asignatura.nombre) > 40 ORDER BY 2 DESC ;
SELECT grado.nombre AS 'nom del grau', SUM(creditos) AS 'creditos', asignatura.tipo FROM asignatura JOIN grado ON asignatura.id_grado = grado.id GROUP BY grado.id, asignatura.tipo;
SELECT anyo_inicio, COUNT(id_alumno) AS 'alums. matriculats' FROM curso_escolar LEFT JOIN alumno_se_matricula_asignatura ON curso_escolar.id = id_curso_escolar GROUP BY curso_escolar.id;
SELECT persona.id, persona.nombre, apellido1, apellido2, COUNT(asignatura.nombre) FROM persona LEFT JOIN asignatura ON id_profesor = persona.id GROUP BY persona.id ORDER BY 5 DESC;
SELECT * FROM persona ORDER BY fecha_nacimiento DESC LIMIT 1;
SELECT apellido1, apellido2, persona.nombre FROM persona LEFT JOIN asignatura ON persona.id = asignatura.id_profesor JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id WHERE asignatura.nombre IS NULL AND departamento.nombre IS NOT NULL;  



