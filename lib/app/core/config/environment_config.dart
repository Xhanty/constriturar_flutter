import 'dart:convert';
import 'package:flutter/services.dart';

class EnvironmentConfig {
  static late Map<String, dynamic> _config;

  /// Carga la configuración desde el archivo correspondiente al entorno.
  static Future<void> loadEnv(String env) async {
    final String content =
        await rootBundle.loadString('assets/config/env_$env.json');
    _config = jsonDecode(content);
  }

  /// Obtiene la URL base de la API configurada.
  static String get apiUrl => _config['API_URL'];

  /// Obtiene el nombre de la app configurado.
  static String get appName => _config['APP_NAME'];
}
