# ADB Manager - Gestor Android

![GitHub Repo Size](https://img.shields.io/github/repo-size/hugooae/ADB-Manager-Gestor-Android) ![GitHub](https://img.shields.io/github/license/hugooae/ADB-Manager-Gestor-Android) ![GitHub last commit](https://img.shields.io/github/last-commit/hugooae/ADB-Manager-Gestor-Android) ![Version](https://img.shields.io/badge/version-1.1.0-blue)

## Descripción

**ADB Manager** es un script en Bash para **gestionar dispositivos Android** mediante ADB de forma sencilla e interactiva. Con él puedes:

* Obtener información completa del dispositivo
* Gestionar aplicaciones (instalar, desinstalar, extraer APK)
* Manipular archivos (subir, descargar, eliminar)
* Tomar capturas de pantalla y grabar video
* Control remoto del dispositivo (toques, botones, abrir URLs)
* Backup y restauración de apps y datos
* **Generar reportes completos del dispositivo en formato texto**
* **Actualizaciones automáticas desde GitHub**

## 🛠️ Instalación

1. Clona el repositorio:

```bash
git clone https://github.com/hugooae/ADB-Manager-Gestor-Android
cd ADB-Manager-Gestor-Android
```

2. Otorga permisos de ejecución:

```bash
chmod +x adb_manager.sh
```

3. Ejecuta el script:

```bash
./adb_manager.sh
```

---

## ✅ Requisitos

* Linux/macOS con terminal Bash
* **ADB (Android Debug Bridge)** instalado:

```bash
sudo apt install android-tools-adb
```

* **curl** para descargar actualizaciones:

```bash
sudo apt install curl
```

* Dispositivo Android con **depuración USB activada**

Para instalar todas las dependencias:
```bash
sudo apt update && sudo apt install -y android-tools-adb curl
```

---

## 📚 Uso

Al ejecutar el script, verás un **menú interactivo**. Solo selecciona la opción deseada y sigue las instrucciones.

### Menús Principales

| Opción | Descripción                              |
| ------ | ---------------------------------------- |
| 1      | Información del dispositivo              |
| 2      | Gestión de aplicaciones                  |
| 3      | Gestión de archivos                      |
| 4      | Capturas y grabación                     |
| 5      | Herramientas avanzadas                   |
| 6      | Red y conectividad                       |
| 7      | Logs y monitoreo                         |
| 8      | Control del dispositivo                  |
| 9      | Backup y restauración                    |
| 10     | Generar Reporte del Dispositivo Conectado|
| 0      | Salir                                    |

---

## 💡 Características destacadas

### Información del Dispositivo
* Modelo y fabricante
* Versión de Android y nivel de API
* Información de batería (nivel, salud, temperatura, voltaje)
* Detalles de CPU y arquitectura
* Memoria RAM y almacenamiento
* Resolución y densidad de pantalla

### Gestión de Aplicaciones
* Listar todas las aplicaciones (sistema y usuario)
* Instalar y desinstalar apps
* Limpiar caché de aplicaciones
* Extraer APK de apps instaladas
* Forzar detención de apps

### Gestión de Archivos
* Subir y descargar archivos
* Crear y eliminar carpetas
* Navegar por el sistema de archivos del dispositivo

### Capturas y Grabación
* Screenshots automáticos
* Grabación de pantalla con duración personalizada

### Reporte Completo del Dispositivo
* **Nuevo en v1.1.0**: Genera un reporte detallado en formato TXT
* Incluye toda la información del dispositivo conectado
* Aplicaciones del sistema y del usuario
* Información de conectividad y seguridad
* Archivo bien estructurado y fácil de leer
* Se guarda con timestamp automático

### Actualizaciones Automáticas
* **Nuevo en v1.1.0**: Verificación de actualizaciones en segundo plano
* Descarga automática desde GitHub
* Crea backup de la versión anterior antes de actualizar
* El usuario elige si actualizar o continuar con la versión actual

### Backup y Restauración
* Backup completo del dispositivo
* Backup de aplicaciones individuales
* Restauración de backups guardados

---

## 🆕 Novedades en v1.1.0

* ✅ Opción 10: **Generar Reporte del Dispositivo Conectado**
  - Reporte completo en archivo TXT
  - Toda la información del teléfono en un solo documento
  - Incluye aplicaciones del sistema y usuario
  - Información detallada de hardware y software

* ✅ **Sistema de actualizaciones automáticas**
  - Verifica automáticamente si hay nueva versión en GitHub
  - Se ejecuta en segundo plano sin bloquear la interfaz
  - Crea backups automáticos antes de actualizar
  - Usuario controla si actualizar o no

* ✅ **Versión en línea 2 del código**
  - Fácil seguimiento de versiones: `#V1.1.0`

---

## 📋 Versiones

* **v1.1.0** (Actual)
  - Reporte completo del dispositivo
  - Sistema de actualizaciones automáticas

* **v1.0.0**
  - Versión inicial con todas las funcionalidades básicas

---

## 📌 Ejemplos de comandos

```bash
# Instalar una APK en el dispositivo
adb install ruta/a/la/app.apk

# Extraer APK de una app instalada
adb shell pm path com.ejemplo.app

# Tomar screenshot
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png ./screenshot.png

# Generar reporte del dispositivo
# Solo selecciona opción 10 en el menú principal
```

---

## 🤝 Contribuciones

¡Toda contribución es bienvenida!

1. Reporta errores: [issues](https://github.com/hugooae/ADB-Manager-Gestor-Android/issues)
2. Sugiere mejoras: [pull requests](https://github.com/hugooae/ADB-Manager-Gestor-Android/pulls)
3. Propon nuevas funciones o scripts relacionados con ADB

---

## 📄 Licencia

Este proyecto está bajo la licencia **GNU General Public License v3.0**.

---

## 🔗 Enlaces útiles

* [Documentación oficial ADB](https://developer.android.com/studio/command-line/adb)
* [Guía de depuración USB Android](https://developer.android.com/studio/debug/dev-options)
* [Repositorio GitHub](https://github.com/hugooae/ADB-Manager-Gestor-Android)

---

**Última actualización**: 6 de diciembre de 2025
