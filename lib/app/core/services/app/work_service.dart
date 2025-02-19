import 'package:constriturar/app/core/models/work_model.dart';
import 'package:constriturar/app/core/services/request_service.dart';

class WorkService {
  final RequestService _requestService = RequestService();

  // Método para obtener todas las obras
  Future<List<WorkModel>> getAll() async {
    final url = 'obras';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final List<dynamic> responseData = response["body"];
      return responseData.map((data) => WorkModel.fromJson(data)).toList();
    }

    return [];
  }

  // Método para obtener una obra por su id
  Future<WorkModel?> getById(WorkModel work) async {
    final url = 'obras/get-obra-by-id/${work.obraId}';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final responseData = response["body"];
      return WorkModel.fromJson(responseData);
    }

    return null;
  }

  // Método para crear una obra
  Future<bool> create(WorkModel work) async {
    final url = 'obras';
    final response = await _requestService.post(url, work.toJson());

    return response != null && response["statusCode"] == 201;
  }

  // Método para actualizar una obra
  Future<bool> update(WorkModel work) async {
    final url = 'obras/${work.obraId}';
    final response = await _requestService.put(url, work.toJson());

    return response != null && response["statusCode"] == 204;
  }

  // Método para desactivar una obra
  Future<bool> disable(WorkModel work) async {
    final url = 'obras/update-obra-estado/${work.obraId}';
    final body = [
      {
        "op": "replace",
        "path": "/Estado",
        "value": 'I',
      },
    ];
    final response = await _requestService.patch(url, body);

    return response != null && response["statusCode"] == 204;
  }
}
