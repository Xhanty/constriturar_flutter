import 'package:constriturar/app/core/models/user_model.dart';
import 'package:constriturar/app/core/services/request_service.dart';

class UserService {
  final RequestService _requestService = RequestService();

  // Método para obtener todos los materiales
  Future<List<UserModel>> getAll() async {
    final url = 'auth/users';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final List<dynamic> responseData = response["body"];
      return responseData.map((data) => UserModel.fromJson(data)).toList();
    }

    return [];
  }

  // Método para crear un material
  Future<bool> create(UserModel material) async {
    final url = 'auth/users';
    final response = await _requestService.post(url, material.toJson());

    return response != null && response["statusCode"] == 201;
  }

  // Método para actualizar un material
  Future<bool> update(UserModel material) async {
    final url = 'auth/users/${material.id}';
    final response = await _requestService.put(url, material.toJson());

    return response != null && response["statusCode"] == 204;
  }

  // Método para desactivar un material
  Future<bool> disable(UserModel material) async {
    final url = 'auth/users/update-usuario-estado/${material.id}';
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
