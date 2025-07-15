#!/bin/bash

# Verificar si estamos en Kali Linux
if ! grep -q "Kali GNU/Linux" /etc/os-release; then
    echo "Este script está optimizado para Kali Linux"
fi

# Rutas
BACKEND_DIR="$PWD/backend"
FRONTEND_DIR="$PWD/frontend"

# Función para iniciar servicios
start_service() {
    local dir=$1
    local cmd=$2
    local title=$3
    
    if [ ! -d "$dir" ]; then
        echo "Error: No se encuentra el directorio $dir"
        exit 1
    fi
    
    xfce4-terminal --title="$title" --working-directory="$dir" -e "bash -c '$cmd; exec bash'" &
}

# Verificar dependencias
command -v xfce4-terminal >/dev/null 2>&1 || {
    echo "Error: xfce4-terminal no encontrado. Instálalo con:"
    echo "sudo apt update && sudo apt install xfce4-terminal"
    exit 1
}

# Iniciar servicios
start_service "$BACKEND_DIR" "mvn spring-boot:run" "BACKEND - Spring Boot"
start_service "$FRONTEND_DIR" "npm run dev" "FRONTEND - React"

echo ""
echo "###############################################"
echo "# Backend (Spring Boot) y Frontend (React)    #"
echo "# se están iniciando en terminales separadas  #"
echo "###############################################"
echo ""