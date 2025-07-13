USE wed;

SELECT u.id_usuario, u.nombre, r.nombre_rol 
FROM usuarios u 
JOIN usuario_rol ur ON u.id_usuario = ur.id_usuario
JOIN roles r ON ur.id_rol = r.id_rol
LIMIT 10;

