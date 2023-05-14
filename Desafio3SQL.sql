CREATE DATABASE desafio_Anabelen_Ilabaca_888;


create table usuarios (id serial, email varchar, nombre varchar, apellido varchar, rol varchar);
select * from usuarios

insert into usuarios (email, nombre, apellido, rol)
values ('maria@gmail.com', 'maria', 'gonzalez', 'usuario');

insert into usuarios (email, nombre, apellido, rol)
values ('matias@gmail.com', 'matias', 'diaz', 'administrador');

insert into usuarios (email, nombre, apellido, rol)
values ('rosa@gmail.com', 'rosa', 'salas', 'usuario');

insert into usuarios (email, nombre, apellido, rol)
values ('carlos@gmail.com', 'carlos', 'gutierrez', 'administrador');

insert into usuarios (email, nombre, apellido, rol)
values ('claudio@gmail.com', 'claudio', 'perez', 'usuario');


create table posts (id serial,titulo varchar, contenido text, fecha_creacion date, fecha_actualizacion date, destacado boolean, usuario_id bigint);

select * from posts;

insert into posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
values ('diabetes', 'Factores de riesgo de la diabetes', '4/05/2022', '5/05/2022', 'true', '2' );

insert into posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
values ('hipertension', 'Tratamiento de la hipertension', '6/08/2022', '7/09/2022', 'false', '2' );

insert into posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
values ('Enfermedades cronicas', 'Actualidad de las enfermedades cronicas', '7/05/2022', '6/06/2022', 'true', '1' );

insert into posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
values ('salud ambiental', 'Contaminacion del aire', '7/05/2022', '6/06/2022', 'true', '3' );

insert into posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
values ('Salud mental', 'Realidad de salud mental', '11/09/2022', '22/10/2022', 'true', NULL );

create table comentarios (id serial, contenido varchar, fecha_creacion date, usuario_id bigint, post_id bigint);

insert into comentarios (contenido, fecha_creacion, usuario_id, post_id)
values ('buen posts', '6/06/2022', 1, 1 );

insert into comentarios (contenido, fecha_creacion, usuario_id, post_id)
values ('Que buen tema', '12/07/2022', 2, 1 );

insert into comentarios (contenido, fecha_creacion, usuario_id, post_id)
values ('Interesante posts', '13/08/2022', 3, 1 );

insert into comentarios (contenido, fecha_creacion, usuario_id, post_id)
values ('Gracias por la informacion', '12/10/2022', 1, 2 );

insert into comentarios (contenido, fecha_creacion, usuario_id, post_id)
values ('Por favor más información', '25/11/2022', 2, 2 );

/* pregunta 2*/

select nombre, email, titulo, contenido from usuarios u
JOIN posts p
ON u.id=p.usuario_id;

/* pregunta 3*/

select u.id, titulo, contenido from usuarios u
JOIN posts p
ON u.id=p.usuario_id
where rol='administrador';

/* pregunta 4*/

select u.id, email, count(p.id) as cantidad from usuarios u
LEFT JOIN posts p
ON u.id=p.usuario_id
group by u.id, u.email
order by cantidad desc;

/* pregunta 5*/

select max(email) from usuarios u
JOIN posts p
ON u.id= p.usuario_id
group by u.id, u.email;

/* pregunta 6*/

select nombre, max(fecha_creacion) from (select p.id, p.contenido, p.fecha_creacion, u.nombre from usuarios u
join posts p
ON u.id = p.usuario_id)as f
group by f.nombre;


/* pregunta 7*/

select titulo, contenido from posts p
JOIN (select post_id, count(post_id) as cantidad
from comentarios group by post_id order by cantidad desc limit 1) as f
ON f.post_id=p.id


/* pregunta 8*/

select p.titulo as titulo_post, p.contenido as contenido_post, c.contenido as contenido_comentario, u.email from posts p
JOIN comentarios c
ON p.id = c.post_id
JOIN usuarios u
ON c.usuario_id=u.id;


/* pregunta 9*/

select fecha_creacion, contenido, usuario_id from comentarios c
JOIN usuarios u
ON c.usuario_id = u.id where fecha_creacion = (select max(fecha_creacion) from comentarios where usuario_id = u.id);


/* pregunta 10*/

select u.email from usuarios u
left join comentarios c
ON u.id = c.usuario_id
GROUP By u.email HAVING count(c.id) = 0;