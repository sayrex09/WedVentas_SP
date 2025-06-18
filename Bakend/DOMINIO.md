# 📖 Documentación Técnica
## 🌐 Acceso Local por Dominio (`miweb.local`) para Aplicaciones Web

## 🎯 Objetivo
Permitir que una aplicación web local (por ejemplo, `http://localhost:8080/Hello`) pueda ser accedida desde **otros dispositivos conectados a la red Wi-Fi local** usando un dominio fácil de recordar, como:
```
http://miweb.local/Hello
```

## 🧱 Componentes Utilizados
| Herramienta  | Descripción |
|--------------|-------------|
| **nginx**    | Actúa como proxy reverso, redirige peticiones del dominio al puerto donde corre la app |
| **dnsmasq**  | Provee resolución DNS local, convierte `miweb.local` en la IP de tu laptop |
| **Bash Script** | Automatiza la limpieza de dominios antiguos y la configuración nueva |
| **Spring Boot App** | Tu aplicación Java escuchando en `http://localhost:8080/Hello` |

## 🖥️ ¿Cómo Funciona?
1. El navegador de otro dispositivo pide acceder a `http://miweb.local/Hello`.
2. Ese dispositivo usa como **servidor DNS** la IP de tu laptop.
3. `dnsmasq` en tu laptop resuelve `miweb.local` como tu IP local (ej: `192.168.1.101`).
4. La petición llega a tu laptop.
5. `nginx` escucha en el puerto 80 y la redirige a `localhost:8080`.
6. Tu app responde con el contenido.

## ⚙️ Pasos del Script Automatizado

### 1. 🔍 Detecta IP local
Identifica la IP de tu laptop en la red (ej. `192.168.1.101`).

### 2. 🧹 Limpia dominios anteriores
Elimina dominios configurados previamente para evitar conflictos.

### 3. 📦 Instala dependencias si no existen
```bash
sudo apt install nginx dnsmasq -y
```

### 4. 🛠️ Configura NGINX
Crea un archivo como `/etc/nginx/sites-available/miweb.local` que apunta al puerto donde corre tu app.

### 5. 🌐 Configura dnsmasq
Resuelve el dominio a tu IP local con:
```conf
address=/miweb.local/192.168.1.101
```

### 6. ✅ Verificación y salida
Mensaje de éxito con los pasos finales para acceder desde otros dispositivos.

## 📱 Conexión desde otros dispositivos
1. Conecta los dispositivos a la misma red Wi-Fi.
2. Configura el DNS con la IP local de tu laptop.
3. Accede a `http://miweb.local/Hello` desde su navegador.

## 📂 Estructura del Script
```
/etc/nginx/sites-available/miweb.local
/etc/nginx/sites-enabled/miweb.local
/etc/dnsmasq.d/miweb.local.conf
```

## 🛡️ Seguridad y buenas prácticas
- No abras puertos hacia Internet.
- Usa solo en redes internas.
- Si reinicias tu red, verifica si tu IP cambió.

## 🧰 ¿Deseas mejorar?
- [ ] Generar QR para que celulares configuren DNS fácilmente
- [ ] Servir aplicación vía HTTPS (auto-signed SSL)
- [ ] Agregar múltiples dominios al mismo servidor