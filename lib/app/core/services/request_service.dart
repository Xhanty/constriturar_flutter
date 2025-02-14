import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:constriturar/app/core/config/environment_config.dart';
import 'package:constriturar/app/core/services/secure_storage_service.dart';

class RequestService {
  final String _baseUrl = EnvironmentConfig.apiUrl;
  final SecureStorageService _secureStorageService = SecureStorageService();

  // Método para refrescar el token de acceso
  Future<bool> _refreshToken() async {
    final url = Uri.parse('$_baseUrl/auth/authentication/refresh-token');
    final accessToken = await _secureStorageService.getAccessToken();
    final refreshToken = await _secureStorageService.getRefreshToken();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'accessToken': accessToken,
          'refreshToken': refreshToken,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Guardar el nuevo token de acceso
        await _secureStorageService.saveTokens(
          responseData['accessToken'],
          responseData['refreshToken'],
        );
        return true;
      }
    } catch (ex) {
      // Log the exception if needed
    }
    return false;
  }

  // Método para realizar la petición HTTP
  Future<http.Response?> _makeRequest(
      Future<http.Response> Function() request) async {
    final response = await request();

    if (response.statusCode == 401) {
      final refreshToken = await _refreshToken();
      if (refreshToken) {
        return await request();
      }
    }

    return response;
  }

  // Método para realizar una petición GET
  Future<Map<String, dynamic>?> get(String url) async {
    final response = await _makeRequest(() async => http.get(
          Uri.parse('$_baseUrl/$url'),
          headers: {
            'Authorization':
                'Bearer ${await _secureStorageService.getAccessToken()}',
            'Content-Type': 'application/json'
          },
        ));

    return response != null
        ? {
            'statusCode': response.statusCode,
            'body': json.decode(response.body)
          }
        : null;
  }

  // Método para realizar una petición POST
  Future<dynamic> post(String url, dynamic body) async {
    final response = await _makeRequest(() async => http.post(
          Uri.parse('$_baseUrl/$url'),
          headers: {
            'Authorization':
                'Bearer ${await _secureStorageService.getAccessToken()}',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(body),
        ));

    return response != null
        ? {
            'statusCode': response.statusCode,
            'body': json.decode(response.body)
          }
        : null;
  }

  // Método para realizar una petición PUT
  Future<dynamic> put(String url, dynamic body) async {
    final response = await _makeRequest(() async => http.put(
          Uri.parse('$_baseUrl/$url'),
          headers: {
            'Authorization':
                'Bearer ${await _secureStorageService.getAccessToken()}',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(body),
        ));

    return response != null
        ? {
            'statusCode': response.statusCode,
            // 'body': json.decode(response.body)
          }
        : null;
  }

  // Método para realizar una petición PATCH
  Future<dynamic> patch(String url, dynamic body) async {
    final response = await _makeRequest(() async => http.patch(
          Uri.parse('$_baseUrl/$url'),
          headers: {
            'Authorization':
                'Bearer ${await _secureStorageService.getAccessToken()}',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(body),
        ));

    return response != null
        ? {
            'statusCode': response.statusCode,
            // 'body': json.decode(response.body)
          }
        : null;
  }
}
