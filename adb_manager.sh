#!/bin/bash
#V1.2.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

get_app_name() {
    local package=$1
    local name=$(adb shell pm dump "$package" 2>/dev/null | grep -m1 "applicationInfo" -A 20 | grep "labelRes" | head -1)
    if [ -z "$name" ]; then
        echo "$package"
    else
        echo "$package"
    fi
}

clear_screen() {
    clear
}

pause() {
    echo -e "\n${YELLOW}Presiona ENTER para continuar...${NC}"
    read
}

check_adb_connection() {
    if ! command -v adb &> /dev/null; then
        echo -e "${RED}ERROR: ADB no está instalado${NC}"
        echo "Instala con: sudo apt install android-tools-adb"
        exit 1
    fi
    
    DEVICE=$(adb devices | grep -w "device" | awk '{print $1}')
    if [ -z "$DEVICE" ]; then
        echo -e "${RED}ERROR: No hay dispositivos conectados${NC}"
        echo "Conecta tu dispositivo y activa la depuración USB"
        exit 1
    fi
    echo -e "${GREEN}✓ Dispositivo conectado: $DEVICE${NC}"
}

setup_device_folder() {
    DEVICE_MODEL=$(adb shell getprop ro.product.model 2>/dev/null | tr -d '\r')
    DEVICE_SERIAL=$(adb shell getprop ro.serialno 2>/dev/null | tr -d '\r')
    DEVICE_NAME="${DEVICE_MODEL}_${DEVICE_SERIAL}"
    DEVICE_FOLDER="$PWD/dispositivos/$DEVICE_NAME"
    
    mkdir -p "$DEVICE_FOLDER"
    mkdir -p "$DEVICE_FOLDER/backups"
    mkdir -p "$DEVICE_FOLDER/apks"
    mkdir -p "$DEVICE_FOLDER/capturas"
    mkdir -p "$DEVICE_FOLDER/logs"
    mkdir -p "$DEVICE_FOLDER/reportes"
    mkdir -p "$DEVICE_FOLDER/descargas"
    
    echo -e "${GREEN}✓ Carpeta de dispositivo: $DEVICE_FOLDER${NC}"
}

check_updates() {
    local REPO_URL="https://raw.githubusercontent.com/hugooae/ADB-Manager-Gestor-Android/main/adb_manager.sh"
    local CURRENT_VERSION=$(sed -n '2p' "$0" | grep -oP '(?<=#V)[0-9.]+' || echo "unknown")
    
    local REMOTE_SCRIPT=$(curl -s "$REPO_URL" 2>/dev/null)
    
    if [ -z "$REMOTE_SCRIPT" ]; then
        return
    fi
    
    local REMOTE_VERSION=$(echo "$REMOTE_SCRIPT" | sed -n '2p' | grep -oP '(?<=#V)[0-9.]+' || echo "unknown")
    
    if [ "$REMOTE_VERSION" != "$CURRENT_VERSION" ]; then
        export UPDATE_AVAILABLE=true
        export REMOTE_VERSION="$REMOTE_VERSION"
        export CURRENT_VERSION="$CURRENT_VERSION"
        export REMOTE_SCRIPT="$REMOTE_SCRIPT"
    fi
}

show_update_dialog() {
    while true; do
        clear_screen
        echo -e "${CYAN}"
        CURRENT_VERSION=$(sed -n '2p' "$0" | grep -oP '(?<=#V)[0-9.]+' || echo "unknown")
        echo "╔═══════════════════════════════════════════════════════════════╗"
        echo "║          ADB MANAGER - Gestor Android                         ║"
        echo "╚═══════════════════════════════════════════════════════════════╝"
        echo "v$CURRENT_VERSION"
        echo "Repositorio: https://github.com/hugooae/ADB-Manager-Gestor-Android"
        echo -e "${NC}"
        echo ""
        echo -e "${YELLOW}════════════════════════════════════════════════════${NC}"
        echo -e "${YELLOW}Nueva versión disponible: v$REMOTE_VERSION${NC}"
        echo -e "${YELLOW}Versión actual: v$CURRENT_VERSION${NC}"
        echo -e "${YELLOW}════════════════════════════════════════════════════${NC}"
        echo ""
        echo "1. Actualizar ahora"
        echo "2. Continuar con versión actual"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1)
                echo -e "${YELLOW}Descargando actualización...${NC}"
                
                local BACKUP_FILE="$0.backup.v$CURRENT_VERSION"
                cp "$0" "$BACKUP_FILE"
                echo -e "${GREEN}Backup creado: $BACKUP_FILE${NC}"
                
                echo "$REMOTE_SCRIPT" > "$0"
                chmod +x "$0"
                
                echo -e "${GREEN}Actualización completada exitosamente${NC}"
                echo -e "${GREEN}Versión: v$CURRENT_VERSION -> v$REMOTE_VERSION${NC}"
                echo ""
                echo -e "${YELLOW}Reiniciando script...${NC}"
                sleep 2
                exec "$0" "$@"
                ;;
            2)
                export UPDATE_AVAILABLE=false
                break
                ;;
            *)
                echo -e "${RED}Opción inválida${NC}"
                sleep 1
                ;;
        esac
    done
}

show_banner() {
    clear_screen
    echo -e "${CYAN}"
    CURRENT_VERSION=$(sed -n '2p' "$0" | grep -oP '(?<=#V)[0-9.]+' || echo "unknown")
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║          ADB MANAGER - Gestor Android                         ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo "v$CURRENT_VERSION"
    echo "Repositorio: https://github.com/hugooae/ADB-Manager-Gestor-Android"
    echo -e "${NC}"
    check_adb_connection
    setup_device_folder
    echo ""
}


main_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}═══ MENÚ PRINCIPAL ═══${NC}"
        echo "1. Información del Dispositivo"
        echo "2. Gestión de Aplicaciones"
        echo "3. Gestión de Archivos"
        echo "4. Capturas y Grabación"
        echo "5. Herramientas Avanzadas"
        echo "6. Red y Conectividad"
        echo "7. Logs y Monitoreo"
        echo "8. Control del Dispositivo"
        echo "9. Backup y Restauración"
        echo "10. Personalización del Sistema"
        echo "11. Herramientas de Seguridad"
        echo "12. Generar Reporte del Dispositivo Conectado"
        echo "0. Salir"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1) device_info_menu ;;
            2) apps_menu ;;
            3) files_menu ;;
            4) capture_menu ;;
            5) advanced_menu ;;
            6) network_menu ;;
            7) logs_menu ;;
            8) control_menu ;;
            9) backup_menu ;;
            10) customization_menu ;;
            11) security_menu ;;
            12) generate_report_menu ;;
            0) echo -e "${GREEN}¡Hasta luego!${NC}"; exit 0 ;;
            *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

device_info_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}═══ INFORMACIÓN DEL DISPOSITIVO ═══${NC}"
        echo "1. Ver información general"
        echo "2. Ver modelo y fabricante"
        echo "3. Ver versión de Android"
        echo "4. Ver estado de batería"
        echo "5. Ver información de CPU"
        echo "6. Ver uso de memoria RAM"
        echo "7. Ver almacenamiento"
        echo "8. Ver temperatura"
        echo "0. Volver"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1) 
                echo -e "\n${CYAN}Información General:${NC}"
                adb shell getprop | grep -E "ro.product|ro.build.version"
                pause
                ;;
            2)
                echo -e "\n${CYAN}Modelo y Fabricante:${NC}"
                echo "Fabricante: $(adb shell getprop ro.product.manufacturer)"
                echo "Modelo: $(adb shell getprop ro.product.model)"
                pause
                ;;
            3)
                echo -e "\n${CYAN}Versión de Android:${NC}"
                echo "Android: $(adb shell getprop ro.build.version.release)"
                echo "SDK: $(adb shell getprop ro.build.version.sdk)"
                pause
                ;;
            4)
            echo -e "\n${CYAN}Estado de Batería:${NC}"
            
            battery_info=$(adb shell dumpsys battery)
            echo "$battery_info"

            health=$(echo "$battery_info" | grep 'health:' | awk '{print $2}')
            level=$(echo "$battery_info" | grep 'level:' | awk '{print $2}')

            case "$health" in
                1)
                    echo -e "${YELLOW}Estado de la batería: Desconocido${NC}"
                    ;;
                2)
                    echo -e "${GREEN}Estado de la batería: Buena${NC}"
                    ;;
                3)
                    echo -e "${RED}Estado de la batería: Sobrecalentamiento${NC}"
                    ;;
                4)
                    echo -e "${RED}Estado de la batería: Muerta${NC}"
                    ;;
                5)
                    echo -e "${RED}Estado de la batería: Sobretensión${NC}"
                    ;;
                6)
                    echo -e "${RED}Estado de la batería: Falla no especificada${NC}"
                    ;;
                7)
                    echo -e "${BLUE}Estado de la batería: Fría${NC}"
                    ;;
                *)
                    echo -e "${YELLOW}Estado de la batería: Valor desconocido${NC}"
                    ;;
            esac

            if [ "$level" -le 10 ]; then
                echo -e "${RED}¡Atención! Nivel de batería muy bajo: ${level}%${NC}"
            fi

            pause
            ;;
            5)
                echo -e "\n${CYAN}Información de CPU:${NC}"
                adb shell cat /proc/cpuinfo
                pause
                ;;
            6)
                echo -e "\n${CYAN}Uso de Memoria RAM:${NC}"
                adb shell dumpsys meminfo
                pause
                ;;
            7)
                echo -e "\n${CYAN}Almacenamiento:${NC}"
                adb shell df -h
                pause
                ;;
            8)
                echo -e "\n${CYAN}Temperatura:${NC}"
                adb shell dumpsys thermalservice
                pause
                ;;
            0) break ;;
            *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

apps_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}═══ GESTIÓN DE APLICACIONES ═══${NC}"
        echo "1. Listar todas las aplicaciones"
        echo "2. Listar apps de terceros"
        echo "3. Listar apps del sistema"
        echo "4. Instalar APK"
        echo "5. Desinstalar aplicación"
        echo "6. Información de una app"
        echo "7. Extraer APK de una app"
        echo "8. Limpiar caché de una app"
        echo "9. Forzar detención de una app"
        echo "0. Volver"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1)
                echo -e "\n${CYAN}Todas las aplicaciones:${NC}"
                adb shell pm list packages | cut -d: -f2 | sort | nl -w2 -s'. '
                pause
                ;;
            2)
                echo -e "\n${CYAN}Apps de terceros:${NC}"
                adb shell pm list packages -3 | cut -d: -f2 | sort | nl -w2 -s'. '
                pause
                ;;
            3)
                echo -e "\n${CYAN}Apps del sistema:${NC}"
                adb shell pm list packages -s | cut -d: -f2 | sort | nl -w2 -s'. '
                pause
                ;;
            4)
                echo -n "Ruta del archivo APK: "
                read apk_path
                if [ -f "$apk_path" ]; then
                    echo -e "${YELLOW}Instalando...${NC}"
                    adb install "$apk_path"
                    echo -e "${GREEN}Instalación completada${NC}"
                else
                    echo -e "${RED}Archivo no encontrado${NC}"
                fi
                pause
                ;;
            5)
                echo -e "\n${CYAN}¿Qué tipo de aplicaciones deseas desinstalar?${NC}"
                echo "1. Aplicaciones de terceros"
                echo "2. Aplicaciones del sistema"
                echo "0. Cancelar"
                echo -n "Selecciona una opción: "
                read app_type
                
                if [ "$app_type" = "0" ]; then
                    echo -e "${YELLOW}Cancelado${NC}"
                    pause
                    continue
                fi
                
                if [ "$app_type" = "1" ]; then
                    echo -e "\n${CYAN}Apps de terceros:${NC}"
                    mapfile -t packages < <(adb shell pm list packages -3 2>/dev/null | cut -d: -f2 | sort)
                    app_source="terceros"
                elif [ "$app_type" = "2" ]; then
                    echo -e "\n${CYAN}Apps del sistema:${NC}"
                    mapfile -t packages < <(adb shell pm list packages -s 2>/dev/null | cut -d: -f2 | sort)
                    app_source="sistema"
                else
                    echo -e "${RED}Opción inválida${NC}"
                    sleep 1
                    pause
                    continue
                fi
                
                if [ ${#packages[@]} -eq 0 ]; then
                    echo -e "${RED}No hay aplicaciones de $app_source disponibles${NC}"
                    pause
                    continue
                fi
                
                for i in "${!packages[@]}"; do
                    echo "$((i+1)). ${packages[$i]}"
                done
                
                echo ""
                echo -n "Número de app a desinstalar (0 para cancelar): "
                read num
                
                if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "${#packages[@]}" ]; then
                    selected_package="${packages[$((num-1))]}"
                    echo -e "${RED}¿Desinstalar $selected_package? (s/n): ${NC}"
                    read confirm
                    if [ "$confirm" = "s" ]; then
                        echo -e "${YELLOW}Desinstalando...${NC}"
                        
                        if [ "$app_source" = "terceros" ]; then
                            result=$(adb uninstall "$selected_package" 2>&1)
                        else
                            result=$(adb shell pm uninstall --user 0 "$selected_package" 2>&1)
                        fi
                        
                        if echo "$result" | grep -q "Success"; then
                            echo -e "${GREEN}✓ Desinstalación completada${NC}"
                        else
                            echo -e "${RED}✗ Error al desinstalar:${NC}"
                            echo "$result"
                        fi
                    fi
                else
                    echo -e "${YELLOW}Cancelado${NC}"
                fi
                pause
                ;;
            6)
                echo -e "\n${CYAN}Selecciona una aplicación:${NC}"
                mapfile -t packages < <(adb shell pm list packages -3 2>/dev/null | cut -d: -f2 | sort)
                
                for i in "${!packages[@]}"; do
                    echo "$((i+1)). ${packages[$i]}"
                done
                
                echo ""
                echo -n "Número de app (0 para cancelar): "
                read num
                
                if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "${#packages[@]}" ]; then
                    selected_package="${packages[$((num-1))]}"
                    echo -e "\n${CYAN}Información de $selected_package:${NC}"
                    adb shell dumpsys package "$selected_package" 2>/dev/null | head -100
                else
                    echo -e "${YELLOW}Cancelado${NC}"
                fi
                pause
                ;;
            7)
                echo -e "\n${CYAN}Selecciona una aplicación:${NC}"
                mapfile -t packages < <(adb shell pm list packages -3 2>/dev/null | cut -d: -f2 | sort)
                
                for i in "${!packages[@]}"; do
                    echo "$((i+1)). ${packages[$i]}"
                done
                
                echo ""
                echo -n "Número de app (0 para cancelar): "
                read num
                
                if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "${#packages[@]}" ]; then
                    selected_package="${packages[$((num-1))]}"
                    APK_PATH=$(adb shell pm path "$selected_package" 2>/dev/null | cut -d: -f2 | tr -d '\r')
                    if [ ! -z "$APK_PATH" ]; then
                        echo -e "${YELLOW}Extrayendo APK...${NC}"
                        adb pull "$APK_PATH" "${selected_package}.apk"
                        echo -e "${GREEN}APK guardado como ${selected_package}.apk${NC}"
                    else
                        echo -e "${RED}No se pudo obtener la ruta del APK${NC}"
                    fi
                else
                    echo -e "${YELLOW}Cancelado${NC}"
                fi
                pause
                ;;
            8)
                echo -e "\n${CYAN}Selecciona una aplicación:${NC}"
                mapfile -t packages < <(adb shell pm list packages -3 2>/dev/null | cut -d: -f2 | sort)
                
                for i in "${!packages[@]}"; do
                    echo "$((i+1)). ${packages[$i]}"
                done
                
                echo ""
                echo -n "Número de app (0 para cancelar): "
                read num
                
                if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "${#packages[@]}" ]; then
                    selected_package="${packages[$((num-1))]}"
                    echo -e "${YELLOW}Limpiando caché de $selected_package...${NC}"
                    adb shell pm clear "$selected_package" 2>/dev/null
                    echo -e "${GREEN}Caché limpiado${NC}"
                else
                    echo -e "${YELLOW}Cancelado${NC}"
                fi
                pause
                ;;
            9)
                echo -e "\n${CYAN}Selecciona una aplicación:${NC}"
                mapfile -t packages < <(adb shell pm list packages -3 2>/dev/null | cut -d: -f2 | sort)
                
                for i in "${!packages[@]}"; do
                    echo "$((i+1)). ${packages[$i]}"
                done
                
                echo ""
                echo -n "Número de app (0 para cancelar): "
                read num
                
                if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "${#packages[@]}" ]; then
                    selected_package="${packages[$((num-1))]}"
                    echo -e "${YELLOW}Deteniendo $selected_package...${NC}"
                    adb shell am force-stop "$selected_package" 2>/dev/null
                    echo -e "${GREEN}App detenida${NC}"
                else
                    echo -e "${YELLOW}Cancelado${NC}"
                fi
                pause
                ;;
            0) break ;;
            *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

files_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}═══ GESTIÓN DE ARCHIVOS ═══${NC}"
        echo "1. Listar archivos (sdcard)"
        echo "2. Subir archivo al dispositivo"
        echo "3. Descargar archivo del dispositivo"
        echo "4. Crear carpeta"
        echo "5. Eliminar archivo/carpeta"
        echo "0. Volver"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1)
                echo -n "Ruta (dejar vacío para /sdcard/): "
                read path
                path=${path:-/sdcard/}
                echo -e "\n${CYAN}Contenido de $path:${NC}"
                mapfile -t files < <(adb shell ls -1 "$path" 2>/dev/null)
                
                if [ ${#files[@]} -eq 0 ]; then
                    echo -e "${RED}Carpeta vacía o no existe${NC}"
                else
                    for i in "${!files[@]}"; do
                        echo "$((i+1)). ${files[$i]}"
                    done
                fi
                pause
                ;;
            2)
                echo -n "Archivo local: "
                read local_file
                echo -n "Ruta destino en dispositivo: "
                read remote_path
                if [ -f "$local_file" ]; then
                    echo -e "${YELLOW}Subiendo archivo...${NC}"
                    adb push "$local_file" "$remote_path"
                    echo -e "${GREEN}Archivo subido${NC}"
                else
                    echo -e "${RED}Archivo no encontrado${NC}"
                fi
                pause
                ;;
            3)
                echo -n "Ruta en dispositivo (dejar vacío para /sdcard/): "
                read remote_path
                remote_path=${remote_path:-/sdcard/}
                
                echo -e "\n${CYAN}Archivos en $remote_path:${NC}"
                mapfile -t files < <(adb shell ls -1 "$remote_path" 2>/dev/null)
                
                if [ ${#files[@]} -eq 0 ]; then
                    echo -e "${RED}Carpeta vacía o no existe${NC}"
                    pause
                    continue
                fi
                
                for i in "${!files[@]}"; do
                    echo "$((i+1)). ${files[$i]}"
                done
                
                echo ""
                echo -n "Número de archivo (0 para cancelar): "
                read num
                
                if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "${#files[@]}" ]; then
                    selected_file="${files[$((num-1))]}"
                    remote_file="$remote_path/$selected_file"
                    echo -n "Guardar como (dejar vacío para usar nombre original): "
                    read local_file
                    local_file=${local_file:-$selected_file}
                    
                    echo -e "${YELLOW}Descargando archivo...${NC}"
                    adb pull "$remote_file" "$local_file"
                    echo -e "${GREEN}Archivo descargado como $local_file${NC}"
                else
                    echo -e "${YELLOW}Cancelado${NC}"
                fi
                pause
                ;;
            4)
                echo -n "Ruta de la nueva carpeta: "
                read folder_path
                adb shell mkdir -p "$folder_path"
                echo -e "${GREEN}Carpeta creada${NC}"
                pause
                ;;
            5)
                echo -n "Ruta en dispositivo (dejar vacío para /sdcard/): "
                read delete_path
                delete_path=${delete_path:-/sdcard/}
                
                echo -e "\n${CYAN}Archivos en $delete_path:${NC}"
                mapfile -t files < <(adb shell ls -1 "$delete_path" 2>/dev/null)
                
                if [ ${#files[@]} -eq 0 ]; then
                    echo -e "${RED}Carpeta vacía o no existe${NC}"
                    pause
                    continue
                fi
                
                for i in "${!files[@]}"; do
                    echo "$((i+1)). ${files[$i]}"
                done
                
                echo ""
                echo -n "Número de archivo/carpeta a eliminar (0 para cancelar): "
                read num
                
                if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "${#files[@]}" ]; then
                    selected_file="${files[$((num-1))]}"
                    full_path="$delete_path/$selected_file"
                    echo -e "${RED}¿Eliminar $selected_file? (s/n): ${NC}"
                    read confirm
                    if [ "$confirm" = "s" ]; then
                        adb shell rm -rf "$full_path"
                        echo -e "${GREEN}Eliminado${NC}"
                    fi
                else
                    echo -e "${YELLOW}Cancelado${NC}"
                fi
                pause
                ;;
            0) break ;;
            *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

capture_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}═══ CAPTURAS Y GRABACIÓN ═══${NC}"
        echo "1. Captura de pantalla"
        echo "2. Grabar pantalla (Ctrl+C para detener)"
        echo "3. Grabar pantalla con tiempo límite"
        echo "0. Volver"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1)
                FILENAME="$DEVICE_FOLDER/capturas/screenshot_$(date +%Y%m%d_%H%M%S).png"
                echo -e "${YELLOW}Capturando pantalla...${NC}"
                adb exec-out screencap -p > "$FILENAME"
                echo -e "${GREEN}Guardado como $FILENAME${NC}"
                pause
                ;;
            2)
                FILENAME="$DEVICE_FOLDER/capturas/grabacion_$(date +%Y%m%d_%H%M%S).mp4"
                echo -e "${YELLOW}Grabando pantalla (Ctrl+C para detener)...${NC}"
                adb shell screenrecord /sdcard/temp_record.mp4
                adb pull /sdcard/temp_record.mp4 "$FILENAME"
                adb shell rm /sdcard/temp_record.mp4
                echo -e "${GREEN}Guardado como $FILENAME${NC}"
                pause
                ;;
            3)
                echo -n "Duración en segundos (máx 180): "
                read duration
                FILENAME="$DEVICE_FOLDER/capturas/grabacion_$(date +%Y%m%d_%H%M%S).mp4"
                echo -e "${YELLOW}Grabando por $duration segundos...${NC}"
                adb shell screenrecord --time-limit "$duration" /sdcard/temp_record.mp4
                adb pull /sdcard/temp_record.mp4 "$FILENAME"
                adb shell rm /sdcard/temp_record.mp4
                echo -e "${GREEN}Guardado como $FILENAME${NC}"
                pause
                ;;
            0) break ;;
            *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

advanced_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}═══ HERRAMIENTAS AVANZADAS ═══${NC}"
        echo "1. Reiniciar dispositivo"
        echo "2. Reiniciar en modo Recovery"
        echo "3. Reiniciar en modo Bootloader"
        echo "4. Ver procesos en ejecución"
        echo "5. Shell interactivo"
        echo "0. Volver"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1)
                echo -e "${RED}¿Reiniciar dispositivo? (s/n): ${NC}"
                read confirm
                if [ "$confirm" = "s" ]; then
                    adb reboot
                    echo -e "${GREEN}Reiniciando...${NC}"
                fi
                pause
                ;;
            2)
                echo -e "${RED}¿Reiniciar en Recovery? (s/n): ${NC}"
                read confirm
                if [ "$confirm" = "s" ]; then
                    adb reboot recovery
                    echo -e "${GREEN}Reiniciando en Recovery...${NC}"
                fi
                pause
                ;;
            3)
                echo -e "${RED}¿Reiniciar en Bootloader? (s/n): ${NC}"
                read confirm
                if [ "$confirm" = "s" ]; then
                    adb reboot bootloader
                    echo -e "${GREEN}Reiniciando en Bootloader...${NC}"
                fi
                pause
                ;;
            4)
                echo -e "\n${CYAN}Procesos en ejecución:${NC}"
                adb shell ps -A
                pause
                ;;
            5)
                echo -e "${YELLOW}Entrando a shell (escribe 'exit' para salir)${NC}"
                adb shell
                ;;
            0) break ;;
            *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

network_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}═══ RED Y CONECTIVIDAD ═══${NC}"
        echo "1. Ver información de WiFi"
        echo "2. Ver IP del dispositivo"
        echo "3. Activar ADB por WiFi"
        echo "4. Conectar por WiFi"
        echo "5. Desconectar WiFi"
        echo "0. Volver"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1)
                echo -e "\n${CYAN}Información WiFi:${NC}"
                adb shell dumpsys wifi | grep -E "Wi-Fi|SSID|IP"
                pause
                ;;
            2)
                echo -e "\n${CYAN}Dirección IP:${NC}"
                adb shell ip addr show wlan0 | grep inet
                pause
                ;;
            3)
                echo -e "${YELLOW}Activando ADB por WiFi en puerto 5555...${NC}"
                adb tcpip 5555
                echo -e "${GREEN}ADB por WiFi activado${NC}"
                echo "Ahora puedes desconectar el USB y usar: adb connect IP:5555"
                pause
                ;;
            4)
                echo -n "IP del dispositivo: "
                read device_ip
                echo -e "${YELLOW}Conectando a $device_ip:5555...${NC}"
                adb connect "$device_ip:5555"
                pause
                ;;
            5)
                echo -n "IP del dispositivo: "
                read device_ip
                adb disconnect "$device_ip:5555"
                echo -e "${GREEN}Desconectado${NC}"
                pause
                ;;
            0) break ;;
            *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

logs_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}═══ LOGS Y MONITOREO ═══${NC}"
        echo "1. Ver logs en tiempo real"
        echo "2. Guardar logs a archivo"
        echo "3. Limpiar logs"
        echo "4. Ver estadísticas de batería"
        echo "5. Ver uso de CPU (top)"
        echo "0. Volver"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1)
                echo -e "${YELLOW}Mostrando logs (Ctrl+C para detener)${NC}"
                adb logcat
                ;;
            2)
                FILENAME="$DEVICE_FOLDER/logs/logs_$(date +%Y%m%d_%H%M%S).txt"
                echo -e "${YELLOW}Guardando logs...${NC}"
                adb logcat -d > "$FILENAME"
                echo -e "${GREEN}Logs guardados en $FILENAME${NC}"
                pause
                ;;
            3)
                adb logcat -c
                echo -e "${GREEN}Logs limpiados${NC}"
                pause
                ;;
            4)
                echo -e "\n${CYAN}Estadísticas de batería:${NC}"
                adb shell dumpsys batterystats
                pause
                ;;
            5)
                echo -e "${YELLOW}Mostrando uso de CPU (q para salir)${NC}"
                adb shell top
                ;;
            0) break ;;
            *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

control_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}═══ CONTROL DEL DISPOSITIVO ═══${NC}"
        echo "1. Presionar botón Home"
        echo "2. Presionar botón Back"
        echo "3. Presionar botón Power"
        echo "4. Presionar botón Menú"
        echo "5. Simular toque en pantalla"
        echo "6. Escribir texto"
        echo "7. Abrir URL"
        echo "0. Volver"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1)
                adb shell input keyevent 3
                echo -e "${GREEN}Botón Home presionado${NC}"
                pause
                ;;
            2)
                adb shell input keyevent 4
                echo -e "${GREEN}Botón Back presionado${NC}"
                pause
                ;;
            3)
                adb shell input keyevent 26
                echo -e "${GREEN}Botón Power presionado${NC}"
                pause
                ;;
            4)
                adb shell input keyevent 82
                echo -e "${GREEN}Botón Menú presionado${NC}"
                pause
                ;;
            5)
                echo -n "Coordenada X: "
                read x
                echo -n "Coordenada Y: "
                read y
                adb shell input tap "$x" "$y"
                echo -e "${GREEN}Toque simulado en ($x, $y)${NC}"
                pause
                ;;
            6)
                echo -n "Texto a escribir: "
                read text
                text=$(echo "$text" | sed 's/ /%s/g')
                adb shell input text "$text"
                echo -e "${GREEN}Texto escrito${NC}"
                pause
                ;;
            7)
                echo -n "URL: "
                read url
                adb shell am start -a android.intent.action.VIEW -d "$url"
                echo -e "${GREEN}URL abierta${NC}"
                pause
                ;;
            0) break ;;
            *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

backup_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}═══ BACKUP Y RESTAURACIÓN ═══${NC}"
        echo "1. Backup completo del dispositivo"
        echo "2. Backup de una aplicación"
        echo "3. Restaurar backup"
        echo "0. Volver"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1)
                FILENAME="$DEVICE_FOLDER/backups/backup_completo_$(date +%Y%m%d_%H%M%S).ab"
                echo -e "${YELLOW}Creando backup completo...${NC}"
                echo "Confirma en el dispositivo"
                adb backup -all -apk -shared -f "$FILENAME"
                echo -e "${GREEN}Backup guardado como $FILENAME${NC}"
                pause
                ;;
            2)
                echo -e "\n${CYAN}Selecciona una aplicación para backup:${NC}"
                mapfile -t packages < <(adb shell pm list packages -3 2>/dev/null | cut -d: -f2 | sort)
                
                for i in "${!packages[@]}"; do
                    echo "$((i+1)). ${packages[$i]}"
                done
                
                echo ""
                echo -n "Número de app (0 para cancelar): "
                read num
                
                if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "${#packages[@]}" ]; then
                    selected_package="${packages[$((num-1))]}"
                    FILENAME="$DEVICE_FOLDER/backups/backup_${selected_package}_$(date +%Y%m%d_%H%M%S).ab"
                    echo -e "${YELLOW}Creando backup de $selected_package...${NC}"
                    echo "Confirma en el dispositivo"
                    adb backup -f "$FILENAME" "$selected_package"
                    echo -e "${GREEN}Backup guardado como $FILENAME${NC}"
                else
                    echo -e "${YELLOW}Cancelado${NC}"
                fi
                pause
                ;;
            3)
                echo -e "\n${CYAN}Archivos de backup disponibles (.ab):${NC}"
                mapfile -t backups < <(ls -1 "$DEVICE_FOLDER/backups/"*.ab 2>/dev/null)
                
                if [ ${#backups[@]} -eq 0 ]; then
                    echo -e "${RED}No hay archivos de backup en $DEVICE_FOLDER/backups${NC}"
                    pause
                    continue
                fi
                
                for i in "${!backups[@]}"; do
                    size=$(ls -lh "${backups[$i]}" | awk '{print $5}')
                    echo "$((i+1)). $(basename "${backups[$i]}") ($size)"
                done
                
                echo ""
                echo -n "Número de backup a restaurar (0 para cancelar): "
                read num
                
                if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "${#backups[@]}" ]; then
                    selected_backup="${backups[$((num-1))]}"
                    echo -e "${YELLOW}Restaurando $(basename "$selected_backup")...${NC}"
                    echo "Confirma en el dispositivo"
                    adb restore "$selected_backup"
                    echo -e "${GREEN}Backup restaurado${NC}"
                else
                    echo -e "${YELLOW}Cancelado${NC}"
                fi
                pause
                ;;
            0) break ;;
            *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

generate_report_menu() {
    show_banner
    echo -e "${BLUE}═══ GENERAR REPORTE DEL DISPOSITIVO ═══${NC}"
    echo ""
    
    TIMESTAMP=$(date +"%d-%m-%Y_%H-%M-%S")
    REPORT_FILE="$DEVICE_FOLDER/reportes/reporte_dispositivo_$TIMESTAMP.txt"
    
    echo -e "${YELLOW}Recopilando información del dispositivo...${NC}"
    
    {
        echo ""
        echo "╔════════════════════════════════════════════════════════════════════════╗"
        echo "║                                                                        ║"
        echo "║           REPORTE COMPLETO DEL DISPOSITIVO ANDROID                    ║"
        echo "║                                                                        ║"
        echo "╚════════════════════════════════════════════════════════════════════════╝"
        echo ""
        echo "Generado con: ADB Manager - Gestor Android"
        echo "Repositorio:  https://github.com/hugooae/ADB-Manager-Gestor-Android"
        echo "Fecha:        $(date '+%d de %B de %Y a las %H:%M:%S')"
        echo ""
        echo "════════════════════════════════════════════════════════════════════════"
        echo ""
        
        echo "INFORMACION GENERAL DEL DISPOSITIVO"
        echo "────────────────────────────────────────────────────────────────────────"
        printf "%-35s %s\n" "Fabricante:" "$(adb shell getprop ro.product.manufacturer 2>/dev/null)"
        printf "%-35s %s\n" "Modelo:" "$(adb shell getprop ro.product.model 2>/dev/null)"
        printf "%-35s %s\n" "Dispositivo:" "$(adb shell getprop ro.product.device 2>/dev/null)"
        printf "%-35s %s\n" "Nombre del Host:" "$(adb shell getprop ro.build.host 2>/dev/null)"
        echo ""
        
        echo "INFORMACION DE SOFTWARE"
        echo "────────────────────────────────────────────────────────────────────────"
        printf "%-35s %s\n" "Version de Android:" "$(adb shell getprop ro.build.version.release 2>/dev/null)"
        printf "%-35s %s\n" "Nivel de API (SDK):" "$(adb shell getprop ro.build.version.sdk 2>/dev/null)"
        printf "%-35s %s\n" "Numero de Compilacion:" "$(adb shell getprop ro.build.id 2>/dev/null)"
        printf "%-35s %s\n" "Usuario de Compilacion:" "$(adb shell getprop ro.build.user 2>/dev/null)"
        printf "%-35s %s\n" "Tipo de Compilacion:" "$(adb shell getprop ro.build.type 2>/dev/null)"
        printf "%-35s %s\n" "Fingerprint:" "$(adb shell getprop ro.build.fingerprint 2>/dev/null)"
        echo ""
        
        echo "INFORMACION DE BATERIA"
        echo "────────────────────────────────────────────────────────────────────────"
        adb shell dumpsys battery 2>/dev/null | grep -E "current level|health|status|temperature|voltage|technology|capacity" | sed 's/^  //'
        echo ""
        
        echo "INFORMACION DE CPU"
        echo "────────────────────────────────────────────────────────────────────────"
        printf "%-35s %s\n" "Procesador:" "$(adb shell getprop ro.hardware 2>/dev/null)"
        printf "%-35s %s\n" "Arquitectura:" "$(adb shell getprop ro.product.cpu.abi 2>/dev/null)"
        printf "%-35s %s\n" "ABI Secundario:" "$(adb shell getprop ro.product.cpu.abilist 2>/dev/null)"
        echo ""
        echo "Detalles del Procesador:"
        adb shell cat /proc/cpuinfo 2>/dev/null | head -20
        echo ""
        
        echo "MEMORIA RAM"
        echo "────────────────────────────────────────────────────────────────────────"
        adb shell dumpsys meminfo 2>/dev/null | head -20
        echo ""
        
        echo "ALMACENAMIENTO"
        echo "────────────────────────────────────────────────────────────────────────"
        adb shell df -h 2>/dev/null | grep -E "^/|Filesystem"
        echo ""
        
        echo "INFORMACION DE PANTALLA"
        echo "────────────────────────────────────────────────────────────────────────"
        printf "%-35s %s\n" "Resolucion:" "$(adb shell wm size 2>/dev/null | sed 's/Physical size: //')"
        printf "%-35s %s\n" "Densidad (DPI):" "$(adb shell wm density 2>/dev/null | sed 's/Physical density: //')"
        echo ""
        
        echo "APLICACIONES DEL SISTEMA"
        echo "────────────────────────────────────────────────────────────────────────"
        local total_system=$(adb shell pm list packages -s 2>/dev/null | wc -l)
        printf "%-35s %s\n" "Total de Aplicaciones:" "$total_system"
        echo ""
        echo "Listado de Aplicaciones del Sistema:"
        adb shell pm list packages -s 2>/dev/null | cut -d: -f2 | sort | nl | head -50
        if [ $(adb shell pm list packages -s 2>/dev/null | wc -l) -gt 50 ]; then
            echo "... y mas aplicaciones"
        fi
        echo ""
        
        echo "APLICACIONES DE USUARIO"
        echo "────────────────────────────────────────────────────────────────────────"
        local total_user=$(adb shell pm list packages -3 2>/dev/null | wc -l)
        printf "%-35s %s\n" "Total de Aplicaciones:" "$total_user"
        echo ""
        echo "Listado de Aplicaciones Instaladas:"
        adb shell pm list packages -3 2>/dev/null | cut -d: -f2 | sort | nl
        echo ""
        
        echo "CONECTIVIDAD"
        echo "────────────────────────────────────────────────────────────────────────"
        printf "%-35s %s\n" "Baseband (Modem):" "$(adb shell getprop ro.baseband 2>/dev/null || echo 'N/A')"
        printf "%-35s %s\n" "Soporte Telefonia:" "$(adb shell getprop ro.telephony.use_old_mnc_mcc 2>/dev/null || echo 'N/A')"
        echo ""
        
        echo "SEGURIDAD"
        echo "────────────────────────────────────────────────────────────────────────"
        printf "%-35s %s\n" "Modo Seguro Activado:" "$(adb shell getprop ro.secure 2>/dev/null)"
        printf "%-35s %s\n" "Depuracion Habilitada:" "$(adb shell getprop ro.debuggable 2>/dev/null)"
        echo ""
        
        echo "════════════════════════════════════════════════════════════════════════"
        echo ""
        echo "╔════════════════════════════════════════════════════════════════════════╗"
        echo "║                     FIN DEL REPORTE                                    ║"
        echo "║                                                                        ║"
        echo "║  Este reporte contiene informacion completa del dispositivo conectado  ║"
        echo "║  Generado automáticamente por ADB Manager                              ║"
        echo "║                                                                        ║"
        echo "╚════════════════════════════════════════════════════════════════════════╝"
        echo ""
        
    } > "$REPORT_FILE" 2>/dev/null
    
    if [ -f "$REPORT_FILE" ] && [ -s "$REPORT_FILE" ]; then
        echo -e "${GREEN}Reporte generado exitosamente${NC}"
        echo ""
        echo -e "  Archivo:   ${CYAN}$REPORT_FILE${NC}"
        echo -e "  Ubicacion: ${CYAN}$PWD/$REPORT_FILE${NC}"
        echo ""
    else
        echo -e "${RED}Error: No se pudo generar el reporte${NC}"
    fi
    
    pause
}

# optimization_menu() {
#     while true; do
#         show_banner
#         echo -e "${BLUE}═══ OPTIMIZACIÓN Y LIMPIEZA ═══${NC}"
#         echo "1. Limpiar caché general"
#         echo "2. Limpiar basura y archivos temporales"
#         echo "3. Listar apps por tamaño"
#         echo "4. Calcular tamaño de carpetas"
#         echo "5. Limpiar RAM (garbage collection)"
#         echo "6. Ver consumo de CPU en tiempo real"
#         echo "0. Volver"
#         echo ""
#         echo -n "Selecciona una opción: "
#         read option
#         
#         case $option in
#             1)
#                 echo -e "${YELLOW}Limpiando caché general...${NC}"
#                 adb shell rm -rf /data/system/usagestats/*
#                 adb shell rm -rf /data/local/tmp/*
#                 echo -e "${GREEN}✓ Caché limpiado${NC}"
#                 pause
#                 ;;
#             2)
#                 echo -e "${YELLOW}Limpiando basura y archivos temporales...${NC}"
#                 adb shell rm -rf /sdcard/Android/data/*/cache/*
#                 adb shell rm -rf /sdcard/DCIM/.thumbnails/*
#                 adb shell rm -rf /data/anr/*
#                 echo -e "${GREEN}✓ Basura eliminada${NC}"
#                 pause
#                 ;;
#             3)
#                 echo -e "\n${CYAN}Apps ordenadas por tamaño (TOP 15):${NC}"
#                 adb shell du -sh /data/app/* 2>/dev/null | sort -hr | head -15
#                 pause
#                 ;;
#             4)
#                 echo -n "Ruta a analizar (ej: /sdcard): "
#                 read path
#                 echo -e "\n${CYAN}Tamaño de carpetas en $path:${NC}"
#                 adb shell du -sh "$path"/* 2>/dev/null | sort -hr | head -10
#                 pause
#                 ;;
#             5)
#                 echo -e "${YELLOW}Limpiando RAM...${NC}"
#                 adb shell sync
#                 adb shell sysctl -w vm.drop_caches=3
#                 echo -e "${GREEN}✓ RAM limpiada${NC}"
#                 pause
#                 ;;
#             6)
#                 echo -e "${YELLOW}Uso de CPU en tiempo real (Ctrl+C para salir):${NC}"
#                 adb shell top -n 1
#                 pause
#                 ;;
#             0) break ;;
#             *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
#         esac
#     done
# }

# permissions_menu() {
#     while true; do
#         show_banner
#         echo -e "${BLUE}═══ GESTIÓN DE PERMISOS ═══${NC}"
#         echo "1. Listar permisos de una app"
#         echo "2. Otorgar permiso a una app"
#         echo "3. Revocar permiso de una app"
#         echo "4. Cambiar permisos peligrosos"
#         echo "0. Volver"
#         echo ""
#         echo -n "Selecciona una opción: "
#         read option
#         
#         case $option in
#             1)
#                 echo -e "\n${CYAN}Selecciona una aplicación:${NC}"
#                 mapfile -t packages < <(adb shell pm list packages -3 2>/dev/null | cut -d: -f2 | sort)
#                 
#                 for i in "${!packages[@]}"; do
#                     echo "$((i+1)). ${packages[$i]}"
#                 done
#                 
#                 echo ""
#                 echo -n "Número de app (0 para cancelar): "
#                 read num
#                 
#                 if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "${#packages[@]}" ]; then
#                     selected_package="${packages[$((num-1))]}"
#                     echo -e "\n${CYAN}Permisos de $selected_package:${NC}"
#                     adb shell dumpsys package "$selected_package" 2>/dev/null | grep -A 50 "granted permissions" | head -30
#                 else
#                     echo -e "${YELLOW}Cancelado${NC}"
#                 fi
#                 pause
#                 ;;
#             2)
#                 echo -n "Paquete de la app: "
#                 read package_name
#                 echo "Permisos comunes:"
#                 echo "1. android.permission.CAMERA"
#                 echo "2. android.permission.ACCESS_FINE_LOCATION"
#                 echo "3. android.permission.READ_CONTACTS"
#                 echo "4. android.permission.WRITE_EXTERNAL_STORAGE"
#                 echo "5. Personalizado"
#                 echo -n "Selecciona o ingresa el permiso: "
#                 read perm_choice
#                 
#                 case $perm_choice in
#                     1) permission="android.permission.CAMERA" ;;
#                     2) permission="android.permission.ACCESS_FINE_LOCATION" ;;
#                     3) permission="android.permission.READ_CONTACTS" ;;
#                     4) permission="android.permission.WRITE_EXTERNAL_STORAGE" ;;
#                     5) echo -n "Ingresa el permiso completo: "; read permission ;;
#                     *) permission="$perm_choice" ;;
#                 esac
#                 
#                 echo -e "${YELLOW}Otorgando $permission...${NC}"
#                 adb shell pm grant "$package_name" "$permission"
#                 echo -e "${GREEN}✓ Permiso otorgado${NC}"
#                 pause
#                 ;;
#             3)
#                 echo -n "Paquete de la app: "
#                 read package_name
#                 echo -n "Permiso a revocar (ej: android.permission.CAMERA): "
#                 read permission
#                 
#                 echo -e "${YELLOW}Revocando $permission...${NC}"
#                 adb shell pm revoke "$package_name" "$permission"
#                 echo -e "${GREEN}✓ Permiso revocado${NC}"
#                 pause
#                 ;;
#             4)
#                 echo -e "\n${CYAN}Selecciona una aplicación:${NC}"
#                 mapfile -t packages < <(adb shell pm list packages -3 2>/dev/null | cut -d: -f2 | sort)
#                 
#                 for i in "${!packages[@]}"; do
#                     echo "$((i+1)). ${packages[$i]}"
#                 done
#                 
#                 echo ""
#                 echo -n "Número de app (0 para cancelar): "
#                 read num
#                 
#                 if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "${#packages[@]}" ]; then
#                     selected_package="${packages[$((num-1))]}"
#                     echo -e "\n${CYAN}Permisos peligrosos de $selected_package:${NC}"
#                     echo "1. CAMERA"
#                     echo "2. ACCESS_FINE_LOCATION"
#                     echo "3. READ_CONTACTS"
#                     echo "4. READ_CALL_LOG"
#                     echo "5. READ_EXTERNAL_STORAGE"
#                     echo -n "¿Revocar todos? (s/n): "
#                     read confirm
#                     
#                     if [ "$confirm" = "s" ]; then
#                         adb shell pm revoke "$selected_package" android.permission.CAMERA 2>/dev/null
#                         adb shell pm revoke "$selected_package" android.permission.ACCESS_FINE_LOCATION 2>/dev/null
#                         adb shell pm revoke "$selected_package" android.permission.READ_CONTACTS 2>/dev/null
#                         adb shell pm revoke "$selected_package" android.permission.READ_CALL_LOG 2>/dev/null
#                         adb shell pm revoke "$selected_package" android.permission.READ_EXTERNAL_STORAGE 2>/dev/null
#                         echo -e "${GREEN}✓ Permisos peligrosos revocados${NC}"
#                     fi
#                 else
#                     echo -e "${YELLOW}Cancelado${NC}"
#                 fi
#                 pause
#                 ;;
#             0) break ;;
#             *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
#         esac
#     done
# }

customization_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}═══ PERSONALIZACIÓN DEL SISTEMA ═══${NC}"
        echo "1. Cambiar DPI de pantalla"
        echo "2. Cambiar fuente del sistema"
        echo "3. Ver propiedades del sistema"
        echo "4. Modificar propiedades (build.prop)"
        echo "5. Cambiar densidad de iconos"
        echo "0. Volver"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1)
                echo -e "${CYAN}DPI actual:${NC}"
                adb shell wm density
                echo ""
                echo -n "Nuevo DPI (320, 360, 400, 480, etc.): "
                read new_dpi
                adb shell wm density "$new_dpi"
                echo -e "${GREEN}✓ DPI cambiado a $new_dpi${NC}"
                echo "Reinicia el dispositivo para aplicar cambios"
                pause
                ;;
            2)
                echo -e "${YELLOW}Fontes del sistema disponibles:${NC}"
                adb shell ls /system/fonts/ 2>/dev/null | head -20
                echo ""
                echo "Nota: Para cambiar la fuente necesitas acceso root"
                echo -e "${CYAN}Fontes personalizadas se pueden colocar en:/sdcard/Fonts/${NC}"
                pause
                ;;
            3)
                echo -n "Propiedad a buscar (ej: ro.build): "
                read prop_name
                echo -e "\n${CYAN}Propiedades encontradas:${NC}"
                adb shell getprop | grep "$prop_name"
                pause
                ;;
            4)
                echo -e "${RED}⚠ Advertencia: Modificar build.prop puede causar problemas${NC}"
                echo -n "¿Continuar? (s/n): "
                read confirm
                
                if [ "$confirm" = "s" ]; then
                    echo -n "Propiedad (ej: ro.build.version.release): "
                    read prop
                    echo -n "Nuevo valor: "
                    read value
                    
                    adb shell "setprop $prop $value" 2>/dev/null
                    echo -e "${GREEN}✓ Propiedad modificada (temporal)${NC}"
                    echo "Nota: Los cambios son temporales. Reinicia para revertir"
                fi
                pause
                ;;
            5)
                echo -e "${CYAN}Densidad de iconos actual:${NC}"
                adb shell wm density
                echo ""
                echo "Para cambiar densidad de iconos instala un launcher personalizado"
                pause
                ;;
            0) break ;;
            *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

security_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}═══ HERRAMIENTAS DE SEGURIDAD ═══${NC}"
        echo "1. Crear backup encriptado"
        echo "2. Ver certificados instalados"
        echo "3. Listar aplicaciones del sistema potencialmente maliciosas"
        echo "4. Generar hash MD5/SHA256 de APK"
        echo "5. Ver información de seguridad"
        echo "0. Volver"
        echo ""
        echo -n "Selecciona una opción: "
        read option
        
        case $option in
            1)
                echo -n "Contraseña para backup: "
                read -s password
                echo ""
                FILENAME="backup_encriptado_$(date +%Y%m%d_%H%M%S).ab"
                echo -e "${YELLOW}Creando backup encriptado...${NC}"
                echo "Confirma en el dispositivo"
                adb backup -all -apk -shared -f "$FILENAME"
                echo -e "${GREEN}✓ Backup guardado como $FILENAME${NC}"
                pause
                ;;
            2)
                echo -e "\n${CYAN}Certificados instalados:${NC}"
                adb shell ls /system/etc/security/cacerts/ 2>/dev/null | head -20
                echo ""
                echo -e "${CYAN}Certificados del usuario:${NC}"
                adb shell ls /data/misc/user/0/cacerts-added/ 2>/dev/null
                pause
                ;;
            3)
                echo -e "\n${CYAN}Apps potencialmente sospechosas:${NC}"
                echo "Buscando apps conocidas como bloatware/malware..."
                adb shell pm list packages -3 | grep -E "com.facebook|com.baidu|com.tencent.mm|com.alibaba" | cut -d: -f2
                echo ""
                echo "Nota: Esto es solo referencia. No es análisis completo de malware"
                pause
                ;;
            4)
                echo -n "Ruta del APK: "
                read apk_path
                if [ -f "$apk_path" ]; then
                    echo -e "\n${CYAN}Hashes del APK:${NC}"
                    echo "MD5: $(md5sum \"$apk_path\" | awk '{print $1}')"
                    echo "SHA256: $(sha256sum \"$apk_path\" | awk '{print $1}')"
                else
                    echo -e "${RED}Archivo no encontrado${NC}"
                fi
                pause
                ;;
            5)
                echo -e "\n${CYAN}Información de Seguridad:${NC}"
                printf "%-35s %s\n" "SELinux:" "$(adb shell getenforce 2>/dev/null)"
                printf "%-35s %s\n" "Depuración USB:" "$(adb shell getprop ro.secure 2>/dev/null)"
                printf "%-35s %s\n" "Verificación de Bootloader:" "$(adb shell getprop ro.oem_unlock_supported 2>/dev/null)"
                printf "%-35s %s\n" "Encrypto:" "$(adb shell getprop ro.crypto.state 2>/dev/null)"
                pause
                ;;
            0) break ;;
            *) echo -e "${RED}Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

check_updates &
UPDATE_PID=$!
wait $UPDATE_PID 2>/dev/null

if [ "$UPDATE_AVAILABLE" = "true" ]; then
    show_update_dialog
fi

main_menu
