import 'package:constriturar/app/core/models/vehicle_model.dart';
import 'package:constriturar/app/core/services/request_service.dart';

class VehicleService {
  final RequestService _requestService = RequestService();

  // Método para obtener todos los vehiculos
  Future<List<VehicleModel>> getAll() async {
    final url = 'vehiculos';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final List<dynamic> responseData = response["body"];
      return responseData.map((data) => VehicleModel.fromJson(data)).toList();
    }

    return [];
  }

  // Método para obtener un vehiculo por su ID
  Future<VehicleModel?> getById(VehicleModel vehiculo) async {
    final url = 'vehiculos/get-vehiculo-by-id/${vehiculo.vehiculoId}';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final responseData = response["body"];
      return VehicleModel.fromJson(responseData);
    }

    return null;
  }

  // Método para crear un vehiculo
  Future<bool> create(VehicleModel vehiculo) async {
    final url = 'vehiculos';
    final response = await _requestService.post(url, vehiculo.toJson());

    return response != null && response["statusCode"] == 201;
  }

  // Método para actualizar un vehiculo
  Future<bool> update(VehicleModel vehiculo) async {
    final url = 'vehiculos/${vehiculo.vehiculoId}';
    final response = await _requestService.put(url, vehiculo.toJson());

    return response != null && response["statusCode"] == 204;
  }

  // Método para desactivar un vehiculo
  Future<bool> disable(VehicleModel vehiculo) async {
    final url = 'vehiculos/update-vehiculo-estado/${vehiculo.vehiculoId}';
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
