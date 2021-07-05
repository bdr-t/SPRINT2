SELECT apellido1, apellido2, persona.nombre, departamento.nombre FROM persona JOIN profesor ON persona.id = id_profesor LEFT JOIN departamento ON id_departamento = departamento.id ORDER BY departamento.nombre, apellido1, apellido2, persona.nombre;
SELECT persona.nombre FROM persona JOIN profesor ON persona.id = id_profesor LEFT JOIN departamento ON id_departamento = departamento.id WHERE departamento.id IS NULL ORDER BY departamento.nombre, apellido1, apellido2, persona.nombre ;
SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento WHERE id_departamento IS NULL;
SELECT apellido1, apellido2, persona.nombre FROM persona JOIN profesor ON persona.id = id_profesor LEFT JOIN asignatura ON persona.id = asignatura.id_profesor WHERE asignatura.nombre IS NULL;
SELECT asignatura.nombre FROM asignatura LEFT JOIN persona ON persona.id = asignatura.id_profesor WHERE id_profesor IS NULL;
SELECT departamento.nombre FROM asignatura JOIN profesor ON asignatura.id_profesor = profesor.id_profesor RIGHT JOIN departamento ON departamento.id = profesor.id_departamento WHERE profesor.id_departamento IS NULL;

