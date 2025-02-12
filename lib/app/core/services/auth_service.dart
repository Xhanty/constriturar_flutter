import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/environment_config.dart';
import 'secure_storage_service.dart';

class AuthService {
  final String _baseUrl = EnvironmentConfig.apiUrl;
  final SecureStorageService _secureStorageService = SecureStorageService();

  // Método para iniciar sesión
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/authentication/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Guardar los tokens en almacenamiento seguro
        await _secureStorageService.saveTokens(
          responseData['accessToken'],
          responseData['refreshToken'],
        );

        return {'success': true};
      } else {
        return {'error': 'Credenciales incorrectas'};
      }
    } catch (ex) {
      return {'error': 'Error al conectar con el servidor'};
    }
  }

  // Método para cerrar sesión
  Future<void> logout() async {
    await _secureStorageService.clearTokens();
  }
}
