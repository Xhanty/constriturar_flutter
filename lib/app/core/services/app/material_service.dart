import 'dart:convert';
import 'package:constriturar/app/core/config/environment_config.dart';
import 'package:constriturar/app/core/models/material_model.dart';
import 'package:constriturar/app/core/services/secure_storage_service.dart';
import 'package:http/http.dart' as http;

class MaterialService {
  final String _baseUrl = EnvironmentConfig.apiUrl;
  final SecureStorageService _secureStorageService = SecureStorageService();

  // Método para obtener todos los materiales
  Future<List<MaterialModel>> fetchMaterials() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/materiales'),
      headers: {
        'Authorization':
            'Bearer ${await _secureStorageService.getAccessToken()}',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => MaterialModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener los materiales');
    }
  }

  // Método para obtener un material por su ID
  Future<MaterialModel> fetchMaterialById(MaterialModel material) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/materiales/get-material-by-id/${material.materialId}'),
      headers: {
        'Authorization':
            'Bearer ${await _secureStorageService.getAccessToken()}',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return MaterialModel.fromJson(data);
    } else {
      throw Exception('Error al obtener el material');
    }
  }

  // Método para crear un material
  Future<void> createMaterial(MaterialModel material) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/materiales'),
      headers: {
        'Authorization':
            'Bearer ${await _secureStorageService.getAccessToken()}',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(material.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear el material');
    }
  }

  // Método para actualizar un material
  Future<void> updateMaterial(MaterialModel material) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/materiales/${material.materialId}'),
      headers: {
        'Authorization':
            'Bearer ${await _secureStorageService.getAccessToken()}',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(material.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el material');
    }
  }
}
