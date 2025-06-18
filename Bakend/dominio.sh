#!/bin/bash

# Script dinámico para levantar un dominio local limpio con nginx + dnsmasq
# Autor: ChatGPT + Sayrex

# === CONFIGURACIÓN PREDETERMINADA ===
DEFAULT_DOMAIN="miweb.local"
DEFAULT_PORT="8080"
DOMAINS_DIR="/etc/nginx/sites-available"
ENABLED_DIR="/etc/nginx/sites-enabled"
DNSMASQ_DIR="/etc/dnsmasq.d"

# === DETECTAR IP LOCAL ===
echo "📡 Detectando IP local..."
IP_LOCAL=$(hostname -I | awk '{print $1}')
echo "🧠 IP detectada: $IP_LOCAL"

# === ENTRADA DEL USUARIO ===
read -p "🌐 Ingresa el nuevo dominio local (default: $DEFAULT_DOMAIN): " DOMAIN
read -p "🔌 Puerto donde corre tu app (default: $DEFAULT_PORT): " PORT

DOMAIN="${DOMAIN:-$DEFAULT_DOMAIN}"
PORT="${PORT:-$DEFAULT_PORT}"
NGINX_SITE="$DOMAINS_DIR/$DOMAIN"
DNSMASQ_CONF="$DNSMASQ_DIR/${DOMAIN}.conf"

# === LIMPIEZA COMPLETA DE CONFIGURACIONES ANTERIORES ===
echo ""
echo "🧹 Eliminando configuraciones anteriores de nginx y dnsmasq..."

# Eliminar archivos .local en nginx
sudo find "$DOMAINS_DIR" -type f -name "*.local" -exec rm -f {} \;
sudo find "$ENABLED_DIR" -type f -name "*.local" -exec rm -f {} \;

# Eliminar reglas dnsmasq que redirijan dominios locales
sudo grep -lr "address=/.*/" "$DNSMASQ_DIR" | xargs -r sudo rm -f

# Eliminar enlaces simbólicos rotos
sudo find "$ENABLED_DIR" -xtype l -delete

# === INSTALAR DEPENDENCIAS SI ES NECESARIO ===
echo ""
echo "📦 Asegurando que nginx y dnsmasq estén instalados..."
sudo apt update
sudo apt install -y nginx dnsmasq

# === CONFIGURACIÓN DE NGINX ===
echo ""
echo "🛠️ Configurando nginx para $DOMAIN en el puerto $PORT..."
sudo bash -c "cat > '$NGINX_SITE'" <<EOF
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        proxy_pass http://localhost:$PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

sudo ln -sf "$NGINX_SITE" "$ENABLED_DIR/$DOMAIN"
sudo mkdir -p /var/log/nginx
sudo touch /var/log/nginx/error.log

echo "🔍 Verificando configuración de nginx..."
if ! sudo nginx -t; then
  echo "❌ Error en configuración de nginx. Abortando..."
  exit 1
fi
sudo systemctl restart nginx

# === CONFIGURACIÓN DE DNSMASQ ===
echo ""
echo "🌐 Configurando dnsmasq para $DOMAIN -> $IP_LOCAL..."
echo "address=/$DOMAIN/$IP_LOCAL" | sudo tee "$DNSMASQ_CONF" > /dev/null
sudo systemctl restart dnsmasq

# === LIMPIEZA DE CACHÉ DNS DEL SISTEMA ===
echo ""
echo "♻️ Limpiando caché DNS del sistema..."
sudo systemd-resolve --flush-caches 2>/dev/null || true

# === RESULTADO FINAL ===
echo ""
echo "✅ ¡Dominio local activado correctamente!"
echo "   ➤ URL: http://$DOMAIN/Hello"
echo "   ➤ IP local: $IP_LOCAL"
echo ""
echo "📱 Para otros dispositivos en la red:"
echo "   ➤ Configura como DNS: $IP_LOCAL"
echo "   ➤ Luego visita: http://$DOMAIN/Hello"
echo "🧠 Si el dominio anterior sigue respondiendo, reinicia navegador o prueba en incógnito."
echo ""
