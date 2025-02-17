import 'package:constriturar/app/core/models/rol_model.dart';
import 'package:constriturar/app/core/models/user_model.dart';
import 'package:constriturar/app/core/services/request_service.dart';

class UserService {
  final RequestService _requestService = RequestService();

  // Método para obtener todos los usuarios
  Future<List<UserModel>> getAll() async {
    final url = 'auth/users';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final List<dynamic> responseData = response["body"];
      return responseData.map((data) => UserModel.fromJson(data)).toList();
    }

    return [];
  }

  // Método para obtener un usuario por su id
  Future<UserModel?> getById(UserModel user) async {
    final url = 'auth/users/get-usuario-by-id/${user.id}';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final responseData = response["body"];
      return UserModel.fromJson(responseData);
    }

    return null;
  }

  // Método para obtener los roles
  Future<List<RolModel>> getRoles() async {
    final url = 'auth/roles';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final List<dynamic> responseData = response["body"];
      return RolModel.fromJsonList(responseData);
    }

    return [];
  }

  // Método para crear un usuario
  Future<bool> create(UserModel usuario) async {
    final url = 'auth/users';
    final response = await _requestService.post(url, usuario.toJson());

    return response != null && response["statusCode"] == 201;
  }

  // Método para actualizar un usuario
  Future<bool> update(UserModel usuario) async {
    final url = 'auth/users/${usuario.id}';
    final response = await _requestService.put(url, usuario.toJson());

    return response != null && response["statusCode"] == 204;
  }

  // Método para desactivar un usuario
  Future<bool> disable(UserModel usuario) async {
    final url = 'auth/users/update-usuario-estado/${usuario.id}';
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
