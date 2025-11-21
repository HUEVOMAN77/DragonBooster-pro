#!/bin/bash

echo "=============================="
echo "🐉 Instalador DragonBooster Ultimate Pro Max 6.0 🐉"
echo "Configuración automática para Termux"
echo "=============================="

# Instalar Termux:API si no está presente
if ! command -v termux-notification &> /dev/null
then
    echo "[*] Instalando Termux:API..."
    pkg update -y
    pkg install termux-api -y
else
    echo "[*] Termux:API ya instalado"
fi

# Crear carpeta boot si no existe
BOOT_DIR="$HOME/.termux/boot"
if [ ! -d "$BOOT_DIR" ]; then
    echo "[*] Creando carpeta de arranque automático..."
    mkdir -p "$BOOT_DIR"
else
    echo "[*] Carpeta de arranque ya existe"
fi

# Copiar DragonBooster Ultimate Pro Max 6.0
SCRIPT_PATH="$BOOT_DIR/DragonBooster_UltimateProMax.sh"

cat << 'EOF' > "$SCRIPT_PATH"
#!/bin/bash

echo "=============================="
echo "🐉 DragonBooster Ultimate Pro Max 6.0 🐉"
echo "Optimización automática para Android gama baja en Termux"
echo "=============================="

# Función para instalar Termux:API si no está presente
instalar_termux_api() {
    if ! command -v termux-notification &> /dev/null
    then
        echo "[*] Instalando Termux:API..."
        pkg update -y
        pkg install termux-api -y
    else
        echo "[*] Termux:API ya instalado"
    fi
}

# Función para optimizar el teléfono
dragonbooster_run() {
    echo "[*] Aplicando optimizaciones..."
    # Limpiar memoria
    sync; echo 3 > /proc/sys/vm/drop_caches 2>/dev/null

    # Ajuste de CPU (modo turbo / ahorro)
    if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq ]; then
        echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 2>/dev/null
    fi
    if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq ]; then
        echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2>/dev/null
    fi

    # Ajuste de I/O si ionice está disponible
    if command -v ionice &> /dev/null; then
        ionice -c2 -n0 -p $$
    fi

    # Notificación de Termux
    if command -v termux-notification &> /dev/null; then
        termux-notification -t "DragonBooster" -c "Optimización completada ✅"
    fi

    echo "[*] Optimización completada."
}

# Ejecutar funciones
instalar_termux_api
dragonbooster_run

echo "=============================="
echo "🐉 DragonBooster Ultimate Pro Max 6.0 listo 🐉"
echo "=============================="
EOF

# Dar permisos de ejecución
chmod +x "$SCRIPT_PATH"
echo "[*] Script DragonBooster copiado y permisos asignados"

echo "=============================="
echo "🐉 Instalación completada 🐉"
echo "Reinicia tu teléfono para activar DragonBooster Ultimate Pro Max 6.0 automáticamente"
echo "=============================="
