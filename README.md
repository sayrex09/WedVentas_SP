# 💻 Sayrex Projects – Plataforma de Venta de Proyectos de Programación

  ![SAYREX](./SAYREX.png)

**Sayrex Projects** es una plataforma moderna para la **compra y venta de proyectos de programación** en diversos lenguajes (Java, Python, JavaScript, TypeScript, etc.). Diseñada con un enfoque modular, incluye un **Backend**, un **Frontend** y un **CRM administrativo**, ofreciendo una solución escalable y segura para desarrolladores y compradores. Este sistema permite a los usuarios explorar proyectos, a los vendedores gestionar sus portafolios y a los administradores supervisar la plataforma.

> 🚀 **Versión actual**: `v1.0.0`  
> ![Licencia](https://img.shields.io/badge/licencia-MIT-green)

---

## 📖 Tabla de Contenidos
- [Descripción General](#descripción-general)
- [Tecnologías](#tecnologías)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Requisitos Previos](#requisitos-previos)
- [Instalación y Configuración](#instalación-y-configuración)
  - [Backend](#backend)
  - [Frontend](#frontend)
  - [CRM](#crm)
- [Uso](#uso)
  - [Backend](#uso-backend)
  - [Frontend](#uso-frontend)
  - [CRM](#uso-crm)
- [Contexto para Panadería](#contexto-para-panadería)
- [Funcionalidades Planeadas](#funcionalidades-planeadas)
- [Capturas de Pantalla](#capturas-de-pantalla)
- [Autor](#autor)
- [Licencia](#licencia)

---

## 📝 Descripción General

**Sayrex Projects** es una plataforma que conecta a desarrolladores con compradores interesados en proyectos de programación en diversos lenguajes. Sus características principales incluyen:
- **Compradores**: Exploran proyectos por lenguaje (Java, Python, JavaScript, etc.), categoría (web, móvil, backend) y nivel (básico, intermedio, avanzado), con opción de comprar y valorar.
- **Vendedores**: Publican proyectos, gestionan su portafolio y revisan estadísticas de ventas.
- **Administradores**: Utilizan un CRM para moderar proyectos, gestionar usuarios y generar reportes.

El sistema está compuesto por:
- **Backend**: APIs RESTful en Spring Boot para gestionar usuarios, proyectos, ventas y autenticación.
- **Frontend**: Interfaz en React + Vite + TypeScript para una experiencia de usuario moderna.
- **CRM**: Panel administrativo en React para supervisión y análisis de la plataforma.

---

## 🛠️ Tecnologías

### Backend
- Java 21
- Spring Boot (Web, Data JPA, Security)
- MySQL
- Hibernate
- Lombok
- Maven
- Swagger (OpenAPI)
- JWT para autenticación

### Frontend
- React 18 + Vite
- TypeScript
- Tailwind CSS
- Axios
- React Router DOM
- Recharts (gráficas)
- React Hook Form / Zod (formularios)
- SweetAlert2 / Toastify (notificaciones)

### CRM
- React 18 + Vite
- TypeScript
- Tailwind CSS
- Axios
- React Router DOM
- Context API (autenticación)
- Recharts (gráficas)
- JWT (rutas protegidas)

---

## 📁 Estructura del Proyecto

```
sayrex-projects/
├── backend/
│   ├── src/main/java/com/sayrex/backend/
│   │   ├── BackendApplication.java
│   │   ├── config/          # JWT, CORS, Swagger
│   │   ├── controller/      # Controladores REST
│   │   ├── dto/            # Objetos de transferencia
│   │   ├── exception/       # Manejo de errores
│   │   ├── model/          # Entidades JPA
│   │   ├── repository/     # Interfaces JPA
│   │   ├── security/       # Seguridad y JWT
│   │   └── service/        # Lógica de negocio
│   ├── src/main/resources/
│   │   ├── application.properties
│   │   └── static/
│   └── pom.xml
├── frontend/
│   ├── public/             # Archivos estáticos
│   ├── src/
│   │   ├── assets/         # Imágenes, íconos
│   │   ├── components/     # Componentes reutilizables
│   │   ├── pages/          # Vistas (Home, Proyecto, etc.)
│   │   ├── services/       # Conexión con backend
│   │   ├── context/        # Estado global
│   │   ├── routes/         # Rutas protegidas
│   │   ├── hooks/          # Hooks personalizados
│   │   ├── App.tsx
│   │   └── main.tsx
│   ├── tsconfig.json
│   ├── tailwind.config.js
│   ├── vite.config.ts
│   └── package.json
├── crm/
│   ├── src/
│   │   ├── components/     # Sidebar, Cards, Charts
│   │   ├── pages/          # Dashboard, Usuarios, Proyectos
│   │   ├── services/       # Conexión con backend
│   │   ├── context/        # Autenticación
│   │   ├── App.tsx
│   │   └── main.tsx
│   ├── tsconfig.json
│   ├── tailwind.config.js
│   ├── vite.config.ts
│   └── package.json
└── README.md
```

---

## 🧰 Requisitos Previos
- Node.js >= 18
- npm >= 9
- Java 21
- Maven
- MySQL 8.0
- Navegador moderno (Chrome, Firefox, Edge)
- Backend corriendo en `http://localhost:8080` para Frontend y CRM.

---

## ⚙️ Instalación y Configuración

### Backend
1. Clona el repositorio:
   ```bash
   git clone https://github.com/tu_usuario/sayrex-backend.git
   cd sayrex-backend
   ```
2. Configura `application.properties`:
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/sayrex_db
   spring.datasource.username=root
   spring.datasource.password=tu_contraseña
   spring.jpa.hibernate.ddl-auto=update
   spring.jpa.show-sql=true
   app.jwt.secret=mi_clave_secreta
   app.jwt.expiration=86400000
   server.port=8080
   ```
3. Ejecuta la aplicación:
   ```bash
   mvn spring-boot:run
   ```
4. Accede a Swagger:
   ```
   http://localhost:8080/swagger-ui/index.html
   ```

### Frontend
1. Clona el repositorio:
   ```bash
   git clone https://github.com/tu_usuario/sayrex-frontend.git
   cd sayrex-frontend
   ```
2. Instala dependencias:
   ```bash
   npm install
   ```
3. Crea un archivo `.env`:
   ```env
   VITE_API_URL=http://localhost:8080/api
   ```
4. Ejecuta en modo desarrollo:
   ```bash
   npm run dev
   ```
5. Accede en: `http://localhost:5173`

### CRM
1. Clona el repositorio:
   ```bash
   git clone https://github.com/tu_usuario/sayrex-crm.git
   cd sayrex-crm
   ```
2. Instala dependencias:
   ```bash
   npm install
   ```
3. Crea un archivo `.env`:
   ```env
   VITE_API_URL=http://localhost:8080/api
   ```
4. Ejecuta en modo desarrollo:
   ```bash
   npm run dev
   ```
5. Accede en: `http://localhost:5174` (cambia el puerto si es necesario).

---

## 📖 Uso

### Uso Backend
- **Registrar usuario**:
  ```bash
  curl -X POST http://localhost:8080/api/auth/register -H "Content-Type: application/json" -d '{"username":"user1","password":"pass123","email":"user1@example.com","role":"USER"}'
  ```
- **Obtener proyectos por lenguaje**:
  ```bash
  curl -X GET http://localhost:8080/api/projects?language=Java -H "Authorization: Bearer <tu_token>"
  ```

### Uso Frontend
- **Compradores**:
  - Navega proyectos en la página principal (`http://localhost:5173`).
  - Filtra por lenguaje (Java, Python, etc.) o categoría.
  - Añade proyectos al carrito y completa la compra.
- **Vendedores**:
  - Accede al panel de vendedor para subir proyectos (por ejemplo, un script Python o una app Java).
  - Edita precios o descripciones.
- **Ejemplo de consumo de API**:
  ```typescript
  import axios from 'axios';

  const fetchProjectsByLanguage = async (language: string) => {
    const response = await axios.get(`${import.meta.env.VITE_API_URL}/projects?language=${language}`, {
      headers: { Authorization: `Bearer ${localStorage.getItem('token')}` }
    });
    return response.data;
  };
  ```

### Uso CRM
- Inicia sesión en `http://localhost:5174/login` con credenciales de administrador.
- **Dashboard**: Visualiza estadísticas de ventas, proyectos por lenguaje (JavaScript, Python, etc.) y usuarios activos.
- **Proyectos**: Aprueba o rechaza proyectos subidos por vendedores.
- **Reportes**: Genera informes en CSV sobre ventas o actividad de usuarios.

---

## 🥐 Contexto para Panadería

**Sayrex Projects** puede adaptarse para gestionar una panadería, permitiendo:
- **Backend**:
  - **Inventario**: Gestiona productos (panes, pasteles) y sus ingredientes.
  - **Pedidos**: Registra y rastrea pedidos con estados (en preparación, entregado).
  - **Clientes**: Almacena datos de clientes y preferencias (por ejemplo, pan integral).
- **Frontend**:
  - **Catálogo**: Muestra productos con filtros (tipo de pan, precio).
  - **Carrito**: Permite pedidos en línea.
  - **Valoraciones**: Los clientes califican productos.
- **CRM**:
  - **Gestión de clientes**: Administra datos y preferencias.
  - **Reportes**: Analiza ventas diarias o semanales.
  - **Promociones**: Modera descuentos o combos.

**Ejemplo de uso**:
- Un cliente selecciona un "pan de chocolate" en el frontend y lo añade al carrito.
- El backend registra el pedido y actualiza el inventario.
- El administrador usa el CRM para aprobar el pedido y generar un reporte de ventas diarias.

---

## 🚀 Funcionalidades Planeadas
- **Backend**:
  - Exportación de reportes en PDF/Excel.
  - Integración con pasarelas de pago (Stripe, PayPal).
  - Notificaciones por correo.
- **Frontend**:
  - Filtros avanzados por lenguaje, nivel o tecnología.
  - Internacionalización (i18n).
  - Notificaciones en tiempo real con WebSockets.
- **CRM**:
  - Panel de soporte y mensajería.
  - Estadísticas avanzadas por lenguaje o categoría.

---

## 📸 Capturas de Pantalla

- **Frontend**:
  ![Página de Inicio](./frontend/public/screenshots/home.png)
  ![Catálogo de Proyectos](./frontend/public/screenshots/projects.png)
- **CRM**:
  ![Dashboard](./crm/public/screenshots/dashboard.png)
  ![Gestión de Proyectos](./crm/public/screenshots/projects.png)

---

## 👨‍💻 Autor

**Cristhian Paul Calloquispe Cusi**  
💼 Desarrollador Full Stack  
🚀 Proyecto bajo la marca **Sayrex**  
📧 [sayrex.dev@gmail.com](mailto:sayrex.dev@gmail.com)

---

## 📄 Licencia

Este proyecto está licenciado bajo la [MIT License](LICENSE).