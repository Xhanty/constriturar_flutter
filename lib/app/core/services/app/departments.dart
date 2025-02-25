import 'package:constriturar/app/core/models/department_model.dart';
import 'package:constriturar/app/core/services/request_service.dart';

class DepartmentService {
  final RequestService _requestService = RequestService();

  // Método para obtener todos los departamentos
  Future<List<DepartmentModel>> getAll() async {
    final url = 'departamentos/get-active-departamentos-with-parameters';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final List<dynamic> responseData = response["body"];
      return responseData
          .map((data) => DepartmentModel.fromJson(data))
          .toList();
    }

    return [];
  }
}
