import 'package:constriturar/app/core/models/city_model.dart';
import 'package:constriturar/app/core/services/request_service.dart';

class CityService {
  final RequestService _requestService = RequestService();

  // Método para obtener todas las ciudades de un departamento
  Future<List<CityModel>> getByDepartment(int departmentId) async {
    final url =
        'municipios/get-active-municipios-by-departamento-id/$departmentId';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final List<dynamic> responseData = response["body"];
      return responseData.map((data) => CityModel.fromJson(data)).toList();
    }

    return [];
  }
}
