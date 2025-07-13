# 📊 Sayrex Projects - Módulo CRM (Panel Administrativo)

Este módulo es la interfaz de administración del sistema **Sayrex Projects**, un CRM moderno que permite a los administradores gestionar usuarios, proyectos, ventas, reportes y estadísticas del sistema de ventas de proyectos de programación.

---

## 📁 Estructura del CRM

```

crm/
├── src/
│   ├── components/           # Componentes reutilizables (Sidebar, Cards, Charts)
│   ├── pages/                # Vistas principales (Dashboard, Usuarios, Proyectos)
│   ├── services/             # Axios y conexión con el backend
│   ├── context/              # Autenticación, estado global
│   ├── App.tsx               # Componente raíz
│   └── main.tsx              # Punto de entrada
├── tailwind.config.js        # Configuración de Tailwind CSS
├── vite.config.ts            # Configuración de Vite
├── tsconfig.json             # Configuración de TypeScript
└── package.json              # Dependencias y scripts

````

---

## 🚀 Tecnologías

- React 18 + Vite
- TypeScript
- Tailwind CSS
- Axios
- React Router DOM
- Context API (para autenticación)
- Recharts (gráficas)
- JWT (para protección de rutas)

---

## ⚙️ Instalación y ejecución

1. Abre una terminal en la carpeta `crm`:

```bash
cd crm
````

2. Instala las dependencias:

```bash
npm install
```

3. Ejecuta en modo desarrollo:

```bash
npm run dev
```

4. Accede desde tu navegador:

```
http://localhost:5173
```

> Si ya usas ese puerto para el frontend, cambia el puerto en `vite.config.ts` o usa otro con:
>
> ```bash
> npm run dev -- --port=5174
> ```

---

## 🔐 Funcionalidades del CRM

* Autenticación y autorización con JWT
* Dashboard con estadísticas (gráficas)
* Gestión de usuarios (roles, permisos)
* Gestión de proyectos publicados
* Gestión de ventas y reportes
* Moderación de comentarios y calificaciones
* Rutas protegidas según el rol `ADMIN`

---

## 🧠 Contexto de Autenticación

El CRM utiliza Context API para manejar el estado del usuario autenticado y proteger las rutas sensibles del panel administrativo.

---

## 📌 Notas

* Este módulo se conecta al backend de Spring Boot en el puerto `http://localhost:8080`
* Asegúrate de que el backend esté corriendo antes de iniciar sesión
* El token JWT se guarda en `localStorage` para persistencia de sesión

---

## ✨ Autor

**Sayrex Projects**
Panel CRM desarrollado como parte de un sistema completo de gestión de ventas de proyectos de programación.

---

## 📄 Licencia

Uso académico y educativo. No redistribuir sin autorización.
