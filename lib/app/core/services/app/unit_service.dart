import 'package:constriturar/app/core/models/unit_model.dart';
import 'package:constriturar/app/core/services/request_service.dart';

class UnitService {
  final RequestService _requestService = RequestService();

  // Método para obtener todos las unidades
  Future<List<UnitModel>> getAll() async {
    final url = 'unidades';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final List<dynamic> responseData = response["body"];
      return responseData.map((data) => UnitModel.fromJson(data)).toList();
    }

    return [];
  }

  // Método para obtener una unidad por su id
  Future<UnitModel?> getById(UnitModel unit) async {
    final url = 'unidades/get-unidad-by-id/${unit.unidadId}';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final responseData = response["body"];
      return UnitModel.fromJson(responseData);
    }

    return null;
  }

  // Método para crear una unidad
  Future<bool> create(UnitModel unit) async {
    final url = 'unidades';
    final response = await _requestService.post(url, unit.toJson());

    return response != null && response["statusCode"] == 201;
  }

  // Método para actualizar una unidad
  Future<bool> update(UnitModel unit) async {
    final url = 'unidades/${unit.unidadId}';
    final response = await _requestService.put(url, unit.toJson());

    return response != null && response["statusCode"] == 204;
  }

  // Método para desactivar una unidad
  Future<bool> disable(UnitModel unit) async {
    final url = 'unidades/update-unidad-estado/${unit.unidadId}';
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
