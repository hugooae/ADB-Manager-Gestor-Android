![ADB Manager Banner](https://github.com/hugooae/ADB-Manager-Gestor-Android/blob/main/multimedia/ADB_M_banner_wbackground.jpg)

![GitHub Repo Size](https://img.shields.io/github/repo-size/hugooae/ADB-Manager-Gestor-Android) ![GitHub](https://img.shields.io/github/license/hugooae/ADB-Manager-Gestor-Android) ![GitHub last commit](https://img.shields.io/github/last-commit/hugooae/ADB-Manager-Gestor-Android) ![Version](https://img.shields.io/badge/version-1.3.0-blue)

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

**INFORMACIÓN Y DISPOSITIVO**
| Opción | Descripción                                 |
| ------ | ------------------------------------------- |
| 1      | Información del Dispositivo                 |
| 2      | Consulta de Garantía                        |
| 3      | Generar Reporte del Dispositivo Conectado   |

**APLICACIONES Y ARCHIVOS**
| Opción | Descripción                                 |
| ------ | ------------------------------------------- |
| 4      | Gestión de Aplicaciones                     |
| 5      | Gestión de Archivos                         |
| 6      | Backup y Restauración                       |

**CAPTURA Y VISUALIZACIÓN**
| Opción | Descripción                                 |
| ------ | ------------------------------------------- |
| 7      | Capturas y Grabación                        |
| 8      | Espejo de Pantalla (Scrcpy)                 |

**SISTEMA Y CONECTIVIDAD**
| Opción | Descripción                                 |
| ------ | ------------------------------------------- |
| 9      | Red y Conectividad                          |
| 10     | Logs y Monitoreo                            |
| 11     | Control del Dispositivo                     |

**CONFIGURACIÓN Y HERRAMIENTAS**
| Opción | Descripción                                 |
| ------ | ------------------------------------------- |
| 12     | Personalización del Sistema                 |
| 13     | Herramientas de Seguridad                   |
| 14     | Herramientas Avanzadas                      |

| Opción | Descripción                                 |
| ------ | ------------------------------------------- |
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
* Aplicaciones del sistema y del usuario (lista completa sin límites)
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

## 🆕 Novedades en v1.3.0

* ✅ **Menú reorganizado por categorías**
  - Información y Dispositivo
  - Aplicaciones y Archivos
  - Captura y Visualización
  - Sistema y Conectividad
  - Configuración y Herramientas
  - Navegación más intuitiva y organizada

* ✅ **Información WiFi mejorada**
  - Modo compacto: Muestra datos esenciales (SSID, IP, RSSI, velocidad, seguridad, etc.)
  - Modo avanzado: Información detallada completa del sistema WiFi
  - Ambos modos accesibles desde la opción 1 del menú Red y Conectividad

* ✅ **Banner mejorado con ASCII art**
  - Nuevo título visual más moderno
  - Información compacta del dispositivo conectado
  - Muestra modelo y fabricante en el header
  - Indica el número de funcionalidades nuevas en la versión

* ✅ **Desinstalación múltiple con rangos**
  - Selecciona varias apps individuales (ej: 1 2 3 14 42)
  - Selecciona rangos de apps (ej: 20-74 para desinstalar del 20 al 74)
  - Combina ambos formatos (ej: 4 1 8 20-74 98 87 102 154-176 199)
  - Funciona tanto para apps de terceros como del sistema
  - Resumen de desinstalaciones exitosas y errores
  - Confirmación antes de desinstalar

* ✅ **Extracción de APKs mejorada**
  - Soporta extracción de APKs divididos (splits)
  - Extrae correctamente apps con múltiples componentes (base + config splits)
  - Crea carpeta organizada por app: `apks/[nombre_app]/`
  - Mantiene nombres originales de archivos
  - Manejo automático de rutas complejas de Android

* ✅ **Nuevas funciones para consulta de garantía**
  - Honor, Lenovo, Huawei, Samsung, Xiaomi, OnePlus, Motorola, OPPO, Vivo, ASUS, Nokia, Google Pixel
  - Consulta directa de garantía con Serial e IMEI del dispositivo

* ✅ **Espejo de pantalla mejorado con Scrcpy**
  - Ver pantalla del dispositivo en tiempo real sin control
  - Espejo con control remoto (mouse y teclado)
  - Control total de la pantalla del dispositivo
  - Integración completa con Scrcpy
  - Opción para habilitar permisos de control automáticamente
  - Soporte para múltiples resoluciones y ratios

* ✅ **Grabación de pantalla avanzada**
  - Grabar pantalla con Scrcpy
  - Grabación sin control (solo video)
  - Ajuste personalizado de resolución
  - Guardado automático en carpeta del dispositivo

* ✅ **Validaciones automáticas**
  - Verificación automática de instalación de Scrcpy
  - Eliminación automática de duplicados en desinstalaciones
  - Gestión automática de permisos INJECT_EVENTS para control remoto

* ✅ **Reportes mejorados**
  - Lista completa de aplicaciones del sistema (sin límites)
  - Muestra todas las aplicaciones sin truncamiento
  - Reportes más detallados y completos

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

**Última actualización**: 8 de diciembre de 2025
