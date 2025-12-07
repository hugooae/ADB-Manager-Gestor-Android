# ADB Manager - Gestor Android

![GitHub Repo Size](https://img.shields.io/github/repo-size/hugooae/ADB-Manager-Gestor-Android) ![GitHub](https://img.shields.io/github/license/hugooae/ADB-Manager-Gestor-Android) ![GitHub last commit](https://img.shields.io/github/last-commit/hugooae/ADB-Manager-Gestor-Android) ![Version](https://img.shields.io/badge/version-1.2.1-blue)

## Descripción

**ADB Manager** es un script en Bash para **gestionar dispositivos Android** mediante ADB de forma sencilla e interactiva. Con él puedes:

* Obtener información completa del dispositivo
* Gestionar aplicaciones (instalar, desinstalar, desactivar/activar, extraer APK)
* Manipular archivos (subir, descargar, eliminar)
* Tomar capturas de pantalla y grabar video
* Control remoto del dispositivo (toques, botones, abrir URLs)
* Backup y restauración de apps y datos
* **Generar reportes completos del dispositivo en formato texto**
* **Actualizaciones automáticas desde GitHub**
* **Carpetas organizadas por dispositivo** - Cada teléfono conectado tiene su propia estructura
* **Personalización del sistema** (DPI, propiedades, fuentes)
* **Herramientas de seguridad** (certificados, análisis de APK, backups encriptados)

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

| Opción | Descripción                                 |
| ------ | ------------------------------------------- |
| 1      | Información del dispositivo                 |
| 2      | Gestión de aplicaciones                     |
| 3      | Gestión de archivos                         |
| 4      | Capturas y grabación                        |
| 5      | Herramientas avanzadas                      |
| 6      | Red y conectividad                          |
| 7      | Logs y monitoreo                            |
| 8      | Control del dispositivo                     |
| 9      | Backup y restauración                       |
| 10     | Personalización del Sistema                 |
| 11     | Herramientas de Seguridad                   |
| 12     | Generar Reporte del Dispositivo Conectado  |
| 0      | Salir                                       |

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
* Desactivar/Activar apps del sistema (sin desinstalar)
* Limpiar caché de aplicaciones
* Extraer APK de apps instaladas
* Forzar detención de apps

### Gestión de Archivos
* Subir y descargar archivos
* Crear y eliminar carpetas
* Navegar por el sistema de archivos del dispositivo
* Buscar archivos por tamaño

### Capturas y Grabación
* Screenshots automáticos
* Grabación de pantalla con duración personalizada

### Personalización del Sistema
* Cambiar DPI de pantalla (zoom)
* Modificar propiedades del sistema (build.prop)
* Ver y cambiar fuentes del sistema
* Cambiar densidad de iconos

### Herramientas de Seguridad
* Crear backups encriptados
* Ver certificados instalados
* Detectar apps potencialmente maliciosas
* Generar hash MD5/SHA256 de APK
* Información de seguridad del sistema (SELinux, Bootloader, etc.)

### Reporte Completo del Dispositivo
* **Nuevo en v1.2.0**: Se guarda en carpeta del dispositivo
* Genera un reporte detallado en formato TXT
* Incluye toda la información del dispositivo conectado
* Aplicaciones del sistema y del usuario
* Información de conectividad y seguridad
* Archivo bien estructurado y fácil de leer
* Se guarda con timestamp automático

### Organización por Dispositivo
* **Nuevo en v1.2.0**: Estructura automática de carpetas
* Cada dispositivo conectado obtiene su propia carpeta
* Estructura: `dispositivos/Modelo_NumeroSerie/`
* Subcarpetas: backups, apks, capturas, logs, reportes, descargas
* Todo automáticamente organizado y centralizado

### Actualizaciones Automáticas
* Verificación de actualizaciones en segundo plano
* Descarga automática desde GitHub
* Crea backup de la versión anterior antes de actualizar
* El usuario elige si actualizar o continuar con la versión actual

### Backup y Restauración
* Backup completo del dispositivo
* Backup de aplicaciones individuales
* Backups encriptados (con contraseña)
* Restauración de backups guardados

---

## 🆕 Novedades en v1.2.1

* ✅ **Eliminación de menús no utilizados**
  - Se han removido completamente las funciones `optimization_menu()` y `permissions_menu()`
  - Menú principal simplificado a 12 opciones principales
  - Código más limpio y enfocado en funcionalidades esenciales

---

## 🆕 Novedades en v1.2.0

* ✅ **Organización por dispositivo**
  - Crea automáticamente carpeta por dispositivo: `Modelo_NumeroSerie`
  - Estructura de carpetas: backups, apks, capturas, logs, reportes, descargas
  - Múltiples dispositivos sin conflictos

* ✅ **Personalización del Sistema**
  - Cambiar DPI de pantalla
  - Modificar propiedades (build.prop)
  - Cambiar fuentes y temas
  - Cambiar densidad de iconos

* ✅ **Herramientas de Seguridad**
  - Backups encriptados
  - Análisis de certificados
  - Detección de malware potencial
  - Hash MD5/SHA256 de APK
  - Información de seguridad del sistema

* ✅ **Versión mejorada en línea 2 del código**
  - Fácil seguimiento de versiones: `#V1.2.0`
  - Banner mejorado con visualización de versión

---

## 📋 Versiones

* **v1.2.1** (Actual)
  - Desinstalación mejorada de apps (sistema y terceros)
  - Estructura de carpetas por dispositivo perfeccionada
  - Banner con visualización mejorada de versión
  - Mejor manejo de errores en desinstalación

* **v1.2.0**
  - Organización automática por dispositivo
  - Personalización del sistema
  - Herramientas de seguridad avanzadas

* **v1.1.0**
  - Reporte completo del dispositivo
  - Sistema de actualizaciones automáticas

* **v1.0.0**
  - Versión inicial con todas las funcionalidades básicas

---

## 📁 Estructura de carpetas

Al ejecutar el script, se crea automáticamente:

```
dispositivos/
└── Xiaomi_2C6B3D5F/          (Modelo_SerialNumber)
    ├── backups/               (Backups completos y de apps)
    ├── apks/                  (APKs extraídos)
    ├── capturas/              (Screenshots y grabaciones)
    ├── logs/                  (Logs del dispositivo)
    ├── reportes/              (Reportes del sistema)
    └── descargas/             (Archivos descargados)
```

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
# Solo selecciona opción 12 en el menú principal
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

**Última actualización**: 7 de diciembre de 2025
