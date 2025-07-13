// en lugar de: const faker = require('faker');
const { faker } = require('@faker-js/faker');

const mysql = require('mysql2');
const crypto = require('crypto');

const conn = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'root',
  database: 'wed'
});

conn.connect(err => {
  if (err) throw err;
  console.log("✅ Conexión a MySQL establecida.");

  // 1. Insertar roles
  const roles = ['USER', 'VENDEDOR', 'ADMIN'];
  roles.forEach(rol => {
    conn.query('INSE  RT IGNORE INTO roles (nombre_rol) VALUES (?)', [rol]);
  });

  const usuarios = [];

  // 2. Insertar usuarios y asignarles rol
  const estados = ['activo', 'inactivo', 'baneado'];
  for (let i = 0; i < 1000; i++) {
    const nombre = faker.person.fullName();
    const correo = faker.internet.email();
    const pass = faker.internet.password();
    //const hash = pass; // guardar directamente la contraseña sin cifrar
    const hash = crypto.createHash('sha256').update(pass).digest('hex');
    const foto = faker.image.avatar();
    const estado = estados[Math.floor(Math.random() * estados.length)];

    conn.query(
      'INSERT INTO usuarios (nombre, correo, contrasena_hash, foto_perfil, estado) VALUES (?, ?, ?, ?, ?)',
      [nombre, correo, hash, foto, estado],
      (err, result) => {
        if (err) return console.error("❌ Usuario:", err.message);

        const id_usuario = result.insertId;
        const id_rol = Math.floor(Math.random() * 3) + 1;

        usuarios.push({ id: id_usuario, rol: id_rol });

        conn.query(
          'INSERT INTO usuario_rol (id_usuario, id_rol) VALUES (?, ?)',
          [id_usuario, id_rol],
          err => {
            if (err) return console.error("❌ Rol:", err.message);
            console.log(`🟢 Usuario ${id_usuario} asignado a rol ${id_rol}`);
          }
        );
      }
    );
  }

  // 3. Esperar a que se inserten usuarios y luego insertar proyectos, comentarios, etc.
  setTimeout(() => {
    usuarios.forEach(user => {
      if (user.rol === 2 || user.rol === 1) { // Vendedor o User puede subir proyectos
        const cantidadProyectos = Math.floor(Math.random() * 3) + 1; // 1 a 3 proyectos
        for (let i = 0; i < cantidadProyectos; i++) {
          const titulo = faker.commerce.productName();
          const descripcion = faker.lorem.paragraph();
          const lenguaje = faker.helpers.arrayElement(['Java', 'Python', 'JavaScript', 'C#', 'PHP']);
          const precio = faker.datatype.boolean() ? 0.00 : faker.commerce.price(5, 100, 2);
          const gratuito = precio == 0.00;
          const archivo = faker.internet.url();
          const repo = faker.internet.url();
          const estado = faker.helpers.arrayElement(['activo', 'oculto', 'suspendido']);


          conn.query(
            `INSERT INTO proyectos 
            (titulo, descripcion, lenguaje_programacion, precio, gratuito, archivo_url, repositorio_url, estado, id_usuario)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [titulo, descripcion, lenguaje, precio, gratuito, archivo, repo, estado, user.id],
            (err, result) => {
              if (err) return console.error("❌ Proyecto:", err.message);

              const id_proyecto = result.insertId;

              // Valoraciones, comentarios y favoritos
              usuarios.forEach(u => {
                if (u.id !== user.id && Math.random() > 0.5) {
                  // Valoración
                  conn.query(
                    'INSERT IGNORE INTO valoraciones (id_usuario, id_proyecto, puntuacion, comentario) VALUES (?, ?, ?, ?)',
                    [u.id, id_proyecto, Math.ceil(Math.random() * 5), faker.lorem.sentence()]
                  );

                  // Comentario
                  conn.query(
                    'INSERT INTO comentarios (id_usuario, id_proyecto, contenido) VALUES (?, ?, ?)',
                    [u.id, id_proyecto, faker.lorem.sentences()]
                  );

                  // Favorito
                  conn.query(
                    'INSERT IGNORE INTO favoritos (id_usuario, id_proyecto) VALUES (?, ?)',
                    [u.id, id_proyecto]
                  );
                }
              });
            }
          );
        }
      }
    });

    // Finalizar conexión después de 5s
    setTimeout(() => {
      conn.end();
      console.log("✅ Base de datos poblada con datos falsos.");
    }, 5000);
  }, 3000);
});
