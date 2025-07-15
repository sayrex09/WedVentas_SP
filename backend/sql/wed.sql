CREATE DATABASE IF NOT EXISTS wed;
USE wed;

-- Tabla de usuarios mejorada
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contrasena_hash VARCHAR(255) NOT NULL,
    proveedor_auth VARCHAR(50) DEFAULT 'local',
    foto_perfil VARCHAR(255),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    estado ENUM('activo', 'inactivo', 'baneado') DEFAULT 'activo',
    ultimo_acceso TIMESTAMP NULL,
    intentos_fallidos TINYINT DEFAULT 0,
    bloqueado_hasta TIMESTAMP NULL,
    biografia TEXT,
    habilidades TEXT,
    INDEX(correo),
    INDEX(estado)
);

-- Tabla de roles mejorada
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    nivel_permisos INT DEFAULT 0
);

-- Asociación de usuarios con roles
CREATE TABLE usuario_rol (
    id_usuario INT,
    id_rol INT,
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion TIMESTAMP NULL,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

-- Tokens de acceso para seguridad
CREATE TABLE tokens_acceso (
    id_token INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    expiracion TIMESTAMP NOT NULL,
    dispositivo VARCHAR(255),
    ip_address VARCHAR(45),
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    INDEX(token),
    INDEX(id_usuario)
);

-- Tablas de categorización
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    icono VARCHAR(50)
);

CREATE TABLE niveles_dificultad (
    id_nivel INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL UNIQUE,
    descripcion TEXT,
    nivel_orden INT DEFAULT 0
);

CREATE TABLE licencias (
    id_licencia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    restricciones TEXT,
    es_opensource BOOLEAN DEFAULT FALSE
);

-- Tabla de proyectos mejorada
CREATE TABLE proyectos (
    id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    descripcion_corta VARCHAR(255),
    lenguaje_programacion VARCHAR(50),
    id_categoria INT,
    id_nivel INT,
    id_licencia INT,
    precio DECIMAL(10,2) DEFAULT 0.00 CHECK (precio >= 0),
    gratuito BOOLEAN DEFAULT FALSE,
    archivo_url VARCHAR(255),
    repositorio_url VARCHAR(255),
    demo_url VARCHAR(255),
    estado ENUM('activo', 'oculto', 'suspendido', 'en_revision') DEFAULT 'en_revision',
    id_usuario INT NOT NULL,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_nivel) REFERENCES niveles_dificultad(id_nivel),
    FOREIGN KEY (id_licencia) REFERENCES licencias(id_licencia),
    INDEX(id_usuario),
    INDEX(estado),
    INDEX(lenguaje_programacion),
    INDEX(id_categoria),
    INDEX(id_nivel),
    FULLTEXT INDEX idx_busqueda_texto (titulo, descripcion, descripcion_corta)
);

-- Tablas para métricas de proyectos
CREATE TABLE metricas_proyecto (
    id_metrica INT AUTO_INCREMENT PRIMARY KEY,
    id_proyecto INT NOT NULL,
    vistas INT DEFAULT 0,
    descargas INT DEFAULT 0,
    favoritos INT DEFAULT 0,
    fecha_metrica DATE,
    UNIQUE KEY (id_proyecto, fecha_metrica),
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto)
);

CREATE TABLE tendencias_lenguajes (
    id_tendencia INT AUTO_INCREMENT PRIMARY KEY,
    lenguaje VARCHAR(50) NOT NULL,
    total_proyectos INT DEFAULT 0,
    total_ventas INT DEFAULT 0,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY (lenguaje)
);

-- Sistema de comentarios mejorado
CREATE TABLE comentarios (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_proyecto INT NOT NULL,
    contenido TEXT,
    respuesta_a INT NULL,
    fecha_comentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('activo', 'oculto') DEFAULT 'activo',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto),
    FOREIGN KEY (respuesta_a) REFERENCES comentarios(id_comentario),
    INDEX(id_proyecto),
    INDEX(id_usuario),
    INDEX(estado)
);

-- Sistema de valoraciones mejorado
CREATE TABLE valoraciones (
    id_valoracion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_proyecto INT NOT NULL,
    puntuacion TINYINT CHECK (puntuacion BETWEEN 1 AND 5),
    comentario TEXT,
    fecha_valoracion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto),
    UNIQUE (id_usuario, id_proyecto),
    INDEX(id_proyecto),
    INDEX(puntuacion)
);

-- Sistema de etiquetas mejorado
CREATE TABLE tags (
    id_tag INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tag VARCHAR(50) UNIQUE,
    uso_count INT DEFAULT 0
);

CREATE TABLE proyecto_tag (
    id_proyecto INT,
    id_tag INT,
    PRIMARY KEY (id_proyecto, id_tag),
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto) ON DELETE CASCADE,
    FOREIGN KEY (id_tag) REFERENCES tags(id_tag),
    INDEX(id_tag)
);

-- Sistema de favoritos
CREATE TABLE favoritos (
    id_favorito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_proyecto INT NOT NULL,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto),
    UNIQUE (id_usuario, id_proyecto),
    INDEX(id_usuario),
    INDEX(id_proyecto)
);

-- Sistema de compras y pagos mejorado
CREATE TABLE metodos_pago (
    id_metodo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_metodo VARCHAR(50) NOT NULL UNIQUE,
    detalles TEXT,
    comision DECIMAL(5,2) DEFAULT 0.00,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_comprador INT NOT NULL,
    id_proyecto INT NOT NULL,
    monto DECIMAL(10,2) CHECK (monto >= 0),
    comision DECIMAL(10,2) DEFAULT 0.00,
    monto_autor DECIMAL(10,2) GENERATED ALWAYS AS (monto - comision) STORED,
    estado ENUM('completado', 'pendiente', 'fallido', 'reembolsado') DEFAULT 'pendiente',
    id_metodo INT,
    transaccion_id VARCHAR(100),
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_comprador) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto),
    FOREIGN KEY (id_metodo) REFERENCES metodos_pago(id_metodo),
    INDEX(id_comprador),
    INDEX(id_proyecto),
    INDEX(estado),
    INDEX(fecha_venta)
);

-- Sistema de suscripciones premium
CREATE TABLE planes_suscripcion (
    id_plan INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    precio_mensual DECIMAL(10,2) NOT NULL,
    beneficios TEXT,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo'
);

CREATE TABLE suscripciones_usuarios (
    id_suscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_plan INT NOT NULL,
    fecha_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_fin TIMESTAMP,
    estado ENUM('activa', 'cancelada', 'expirada') DEFAULT 'activa',
    renovacion_automatica BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_plan) REFERENCES planes_suscripcion(id_plan),
    INDEX(id_usuario),
    INDEX(estado),
    INDEX(fecha_fin)
);

-- Sistema de mensajería mejorado
CREATE TABLE conversaciones (
    id_conversacion INT AUTO_INCREMENT PRIMARY KEY,
    asunto VARCHAR(100),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_ultimo_mensaje TIMESTAMP NULL
);

CREATE TABLE participantes_conversacion (
    id_participante INT AUTO_INCREMENT PRIMARY KEY,
    id_conversacion INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_union TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_conversacion) REFERENCES conversaciones(id_conversacion) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    UNIQUE (id_conversacion, id_usuario)
);

CREATE TABLE mensajes (
    id_mensaje INT AUTO_INCREMENT PRIMARY KEY,
    id_conversacion INT NOT NULL,
    id_remitente INT NOT NULL,
    contenido TEXT,
    leido BOOLEAN DEFAULT FALSE,
    fecha_mensaje TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_conversacion) REFERENCES conversaciones(id_conversacion) ON DELETE CASCADE,
    FOREIGN KEY (id_remitente) REFERENCES usuarios(id_usuario),
    INDEX(id_conversacion),
    INDEX(id_remitente),
    INDEX(leido)
);

-- Sistema de versiones de proyecto mejorado
CREATE TABLE versiones_proyecto (
    id_version INT AUTO_INCREMENT PRIMARY KEY,
    id_proyecto INT NOT NULL,
    version VARCHAR(20) NOT NULL,
    descripcion TEXT,
    archivo_url VARCHAR(255),
    es_estable BOOLEAN DEFAULT FALSE,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto) ON DELETE CASCADE,
    INDEX(id_proyecto),
    UNIQUE (id_proyecto, version)
);

-- Sistema de reportes mejorado
CREATE TABLE tipos_reporte (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    gravedad ENUM('baja', 'media', 'alta') DEFAULT 'media'
);

CREATE TABLE reportes (
    id_reporte INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_proyecto INT NULL,
    id_comentario INT NULL,
    id_tipo INT NOT NULL,
    descripcion TEXT NOT NULL,
    estado ENUM('pendiente', 'en_revision', 'resuelto', 'desestimado') DEFAULT 'pendiente',
    fecha_reporte TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_resolucion TIMESTAMP NULL,
    id_administrador INT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto),
    FOREIGN KEY (id_comentario) REFERENCES comentarios(id_comentario),
    FOREIGN KEY (id_tipo) REFERENCES tipos_reporte(id_tipo),
    FOREIGN KEY (id_administrador) REFERENCES usuarios(id_usuario),
    INDEX(estado),
    INDEX(id_tipo),
    INDEX(fecha_reporte)
);

-- Sistema de notificaciones mejorado
CREATE TABLE tipos_notificacion (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    clave VARCHAR(50) UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    plantilla TEXT,
    es_sistema BOOLEAN DEFAULT FALSE
);

CREATE TABLE notificaciones (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_tipo INT NOT NULL,
    id_relacion INT NULL,
    tipo_relacion VARCHAR(50) NULL,
    contenido TEXT,
    leido BOOLEAN DEFAULT FALSE,
    fecha_notificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_tipo) REFERENCES tipos_notificacion(id_tipo),
    INDEX(id_usuario),
    INDEX(leido),
    INDEX(fecha_notificacion)
);

-- Sistema de configuración mejorado
CREATE TABLE configuracion (
    id_configuracion INT AUTO_INCREMENT PRIMARY KEY,
    clave VARCHAR(50) UNIQUE,
    valor TEXT,
    tipo ENUM('string', 'number', 'boolean', 'json') DEFAULT 'string',
    categoria VARCHAR(50),
    editable BOOLEAN DEFAULT TRUE,
    descripcion TEXT
);

-- Sistema de auditoría mejorado
CREATE TABLE acciones_auditoria (
    id_accion INT AUTO_INCREMENT PRIMARY KEY,
    clave VARCHAR(50) UNIQUE,
    descripcion TEXT,
    nivel_gravedad ENUM('info', 'advertencia', 'error', 'critico') DEFAULT 'info'
);

CREATE TABLE auditoria (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NULL,
    id_accion INT NOT NULL,
    entidad_afectada VARCHAR(50),
    id_entidad INT NULL,
    detalles TEXT,
    ip_address VARCHAR(45),
    user_agent TEXT,
    fecha_auditoria TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_accion) REFERENCES acciones_auditoria(id_accion),
    INDEX(id_usuario),
    INDEX(id_accion),
    INDEX(fecha_auditoria)
);

-- Historial de cambios en proyectos
CREATE TABLE historial_proyecto (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_proyecto INT NOT NULL,
    id_usuario INT NOT NULL,
    accion VARCHAR(50) NOT NULL,
    campo_modificado VARCHAR(50),
    valor_anterior TEXT,
    valor_nuevo TEXT,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    INDEX(id_proyecto),
    INDEX(id_usuario),
    INDEX(fecha_cambio)
);

-- Sistema de transacciones financieras
CREATE TABLE transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo ENUM('venta', 'suscripcion', 'retiro', 'reembolso', 'otro') NOT NULL,
    referencia_id INT NULL,
    monto DECIMAL(10,2) NOT NULL,
    moneda VARCHAR(3) DEFAULT 'USD',
    estado ENUM('completado', 'pendiente', 'fallido', 'reversado') DEFAULT 'pendiente',
    metodo_pago VARCHAR(50),
    detalles TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    INDEX(id_usuario),
    INDEX(tipo),
    INDEX(estado),
    INDEX(fecha)
);

-- Sistema de retiros para autores
CREATE TABLE retiros_autores (
    id_retiro INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    metodo_retiro VARCHAR(50) NOT NULL,
    datos_metodo TEXT NOT NULL,
    estado ENUM('pendiente', 'procesando', 'completado', 'rechazado') DEFAULT 'pendiente',
    fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_procesamiento TIMESTAMP NULL,
    id_administrador INT NULL,
    notas TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_administrador) REFERENCES usuarios(id_usuario),
    INDEX(id_usuario),
    INDEX(estado),
    INDEX(fecha_solicitud)
);

-- Tabla de balance de usuarios
CREATE TABLE balance_usuarios (
    id_balance INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    balance_disponible DECIMAL(10,2) DEFAULT 0.00,
    balance_pendiente DECIMAL(10,2) DEFAULT 0.00,
    total_ganado DECIMAL(10,2) DEFAULT 0.00,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    UNIQUE (id_usuario),
    INDEX(balance_disponible)
);

-- Tabla de logs del sistema mejorada
CREATE TABLE logs_sistema (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    nivel ENUM('DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL') NOT NULL,
    origen VARCHAR(100),
    mensaje TEXT,
    contexto JSON,
    ip_address VARCHAR(45),
    user_agent TEXT,
    fecha_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX(nivel),
    INDEX(origen),
    INDEX(fecha_log)
);

-- Logs de accesos 
CREATE TABLE accesos_usuarios (
    id_acceso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_acceso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent TEXT,
    exito BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    INDEX(id_usuario),
    INDEX(fecha_acceso)
);
