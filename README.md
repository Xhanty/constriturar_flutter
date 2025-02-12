# Constriturar - Documentación

## **Índice**
1. [Introducción](#introducción)
2. [Estructura del Proyecto](#estructura-del-proyecto)
3. [Configuración de Ambientes](#configuración-de-ambientes)
4. [Comandos de Ejecución](#comandos-de-ejecución)
5. [Recomendaciones](#recomendaciones)

---

## **Introducción**
Descripción del proyecto.

---

## **Estructura del Proyecto**
```plaintext
project_root/
├── android/
├── ios/
├── lib/
│   ├── app/
│   ├── core/
│   ├── routes/
│   ├── views/
│   ├── widgets/
│   ├── app.dart
│   └── main.dart
├── assets/
│   ├── images/
│   ├── fonts/
│   └── config/
└── pubspec.yaml
```

---

## **Configuración de Ambientes**
La aplicación está configurada para manejar tres ambientes:

1. **Desarrollo (`dev`)**: configuración para pruebas locales.
2. **Staging (`staging`)**: ambiente de pruebas.
3. **Producción (`prod`)**: configuración para el entorno final.

### **Archivos de Configuración por Ambiente**
Ubicados en `assets/config/`:

---

## **Comandos de Ejecución**
Para compilar y ejecutar la app en un entorno específico, utiliza el siguiente comando:

### **Desarrollo (`dev`)**
```bash
flutter run --dart-define=ENV=dev
```

### **Staging (`staging`)**
```bash
flutter run --dart-define=ENV=staging
```

### **Producción (`prod`)**
```bash
flutter run --dart-define=ENV=prod
```

---

## ** Versiones **
- Flutter 3.27.4
- Tools • Dart 3.6.2 • DevTools 2.40.3

---

## **Recomendaciones**
- Mantén el archivo `pubspec.yaml` actualizado con cualquier nuevo asset.
- No incluyas archivos sensibles en los archivos de configuración por ambiente.
- Usa variables de entorno seguras para credenciales sensibles en los ambientes de staging y producción.