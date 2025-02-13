import 'package:constriturar/app/core/services/request_service.dart';
import 'package:constriturar/app/core/models/material_model.dart';

class MaterialService {
  final RequestService _requestService = RequestService();

  // Método para obtener todos los materiales
  Future<List<MaterialModel>> getAll() async {
    final url = 'materiales';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final List<dynamic> responseData = response["body"];
      return responseData.map((data) => MaterialModel.fromJson(data)).toList();
    }

    return [];
  }

  // Método para obtener un material por su ID
  Future<MaterialModel?> getById(MaterialModel material) async {
    final url = 'materiales/get-material-by-id/${material.materialId}';
    final response = await _requestService.get(url);

   if (response != null && response["statusCode"] == 200) {
      final responseData = response["body"];
      return MaterialModel.fromJson(responseData);
    }

    return null;
  }

  // Método para crear un material
  Future<bool> create(MaterialModel material) async {
    final url = 'materiales';
    final response = await _requestService.post(url, material.toJson());

    return response != null && response["statusCode"] == 201;
  }

  // Método para actualizar un material
  Future<bool> update(MaterialModel material) async {
    final url = 'materiales/${material.materialId}';
    final response = await _requestService.put(url, material.toJson());

    return response != null && response["statusCode"] == 200;
  }
}
