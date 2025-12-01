# ADB Manager - Gestor Android

![GitHub Repo Size](https://img.shields.io/github/repo-size/hugooae/ADB-Manager-Gestor-Android) ![GitHub](https://img.shields.io/github/license/hugooae/ADB-Manager-Gestor-Android) ![GitHub last commit](https://img.shields.io/github/last-commit/hugooae/ADB-Manager-Gestor-Android)

## Descripción

**ADB Manager** es un script en Bash para **gestionar dispositivos Android** mediante ADB de forma sencilla e interactiva. Con él puedes:

* Obtener información completa del dispositivo 📱
* Gestionar aplicaciones (instalar, desinstalar, extraer APK) 🛠️
* Manipular archivos (subir, descargar, eliminar) 📂
* Tomar capturas de pantalla y grabar video 🎥
* Control remoto del dispositivo (toques, botones, abrir URLs) 🔥
* Backup y restauración de apps y datos 💾

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

* Dispositivo Android con **depuración USB activada**

---

## 📚 Uso

Al ejecutar el script, verás un **menú interactivo**. Solo selecciona la opción deseada y sigue las instrucciones.

### Menús Principales

| Opción | Descripción                    |
| ------ | ------------------------------ |
| 1      | Información del dispositivo  |
| 2      | Gestión de aplicaciones      |
| 3      | Gestión de archivos          |
| 4      | Capturas y grabación         |
| 5      | Herramientas avanzadas       |
| 6      | Red y conectividad           |
| 7      | Logs y monitoreo             |
| 8      | Control del dispositivo     |
| 9      | Backup y restauración        |
| 0      | Salir                         |

---

## 💡 Características destacadas

* **Información del dispositivo**: modelo, versión de Android, batería, CPU, RAM, almacenamiento, temperatura 🌡️
* **Gestión de apps**: listar, instalar, desinstalar, limpiar caché, extraer APK
* **Gestión de archivos**: subir, descargar, crear, eliminar carpetas y archivos
* **Capturas y grabación**: screenshots y videos de pantalla
* **Control remoto**: tocar, escribir texto, abrir URLs, simular botones físicos
* **Backup y restauración**: respaldos completos o de apps individuales

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

---
