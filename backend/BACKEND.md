# 🛒 Sayrex Projects - Backend

Este repositorio contiene el **backend del sistema Sayrex Projects**, una plataforma moderna para la **compra y venta de proyectos de programación**, tanto frontend como backend. Desarrollado con **Spring Boot**, el sistema ofrece una arquitectura **segura, escalable y modular**, ideal para impulsar una comunidad de programadores que deseen monetizar sus soluciones.

---

## 🚀 Tecnologías Utilizadas

* **Java 21**
* **Spring Boot**

  * Spring Web
  * Spring Data JPA
  * Spring Security (JWT)
* **MySQL**
* **Hibernate**
* **Lombok**
* **Maven**
* **Swagger (OpenAPI)**

---

## 🧠 Descripción del Proyecto

**Sayrex Projects** es una plataforma donde los usuarios pueden:

* Comprar proyectos listos de programación (frontend y backend).
* Vender sus propios proyectos a la comunidad.
* Gestionar su portafolio y ventas si son **vendedores**.
* Acceder a un **CRM administrativo** para supervisar la actividad de la plataforma (ventas, usuarios, reportes).

### 🔐 Roles del Sistema

* 👤 **Usuario**: Puede registrarse, navegar, comprar proyectos y dejar valoraciones.
* 💼 **Vendedor**: Publica y gestiona proyectos a la venta, revisa sus ingresos y estadísticas.
* 🛠️ **Administrador (CRM)**: Gestiona toda la plataforma, incluyendo moderación, reportes, estadísticas globales, y control de usuarios y proyectos.

---

## 📁 Estructura del Proyecto
   
```
  backend/
  ├── src/main/java/com/sayrex/backend/
  │   ├── BackendApplication.java       ← Clase principal
  │   ├── config/                       ← Configuraciones globales (JWT, CORS, Swagger)
  │   ├── controller/                   ← Controladores REST
  │   ├── dto/                          ← Objetos de transferencia de datos
  │   ├── exception/                    ← Manejo de errores personalizados
  │   ├── model/                        ← Entidades JPA (Usuario, Proyecto, Venta, etc.)
  │   ├── repository/                   ← Interfaces JPA para acceso a datos
  │   ├── security/                     ← Seguridad y autenticación JWT
  │   └── service/                      ← Lógica de negocio (servicios)
  ├── src/main/resources/
  │   ├── application.properties        ← Configuraciones de entorno
  │   └── static/                       ← Archivos estáticos (si aplica)
  ├── pom.xml                           ← Dependencias Maven
  └── README.md                         ← Documentación del proyecto
```
   
---

## ⚙️ Configuración del Entorno

1. **Clonar el repositorio**

```bash
git clone https://github.com/tu_usuario/sayrex-backend.git
cd sayrex-backend
```

2. **Configurar `application.properties`**

```properties
# Base de datos
spring.datasource.url=jdbc:mysql://localhost:3306/sayrex_db
spring.datasource.username=root
spring.datasource.password=tu_contraseña

# JPA
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# JWT
app.jwt.secret=mi_clave_secreta
app.jwt.expiration=86400000

# Puerto
server.port=8080
```

3. **Ejecutar la aplicación**

```bash
mvn spring-boot:run
```

4. **Acceder a la documentación Swagger**

```
http://localhost:8080/swagger-ui/index.html
```

---

## 🛡️ Seguridad y Autenticación

* ✅ **Login y Registro** públicos
* 🔐 **JWT** para autenticar usuarios y proteger rutas privadas
* 🔄 Control de acceso basado en **roles**
* 🧩 Filtros personalizados de seguridad

---

## 📦 Módulos Clave

* 🧑‍💻 **Gestión de Proyectos**: Crear, actualizar, eliminar y comprar proyectos.
* 💰 **Ventas y Compras**: Registro de transacciones, historial, carrito de compras.
* ⭐ **Valoraciones y Comentarios**: Interacción entre usuarios.
* 🗂️ **Panel del Vendedor**: Control y estadísticas de sus productos.
* 📊 **CRM Administrativo**: Vista general del sistema, usuarios, reportes y moderación.

---

## 🧪 Pruebas

> Próximamente: integración de pruebas unitarias y de integración con **JUnit** y **Mockito**.

---

## 📌 Funcionalidades Planeadas

* 📊 Generación de reportes en PDF y Excel
* 📬 Notificaciones por correo electrónico
* 💳 Integración con pasarelas de pago (Stripe, PayPal)
* 🧾 Facturación automática
* 🔔 Sistema de notificaciones en tiempo real
* 🌍 Internacionalización (i18n)

---

## 🧑‍💻 Autor

**Cristhian Paul Calloquispe Cusi**
💼 Desarrollador Full Stack
🚀 Proyecto bajo la marca **Sayrex**
📧 [sayrex.dev@gmail.com](mailto:sayrex.dev@gmail.com) *(opcional)*

---

## 📃 Licencia

Este proyecto está licenciado bajo la **MIT License**.
