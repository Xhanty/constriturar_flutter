import 'package:constriturar/app/core/models/client_model.dart';
import 'package:constriturar/app/core/services/request_service.dart';

class ClientService {
  final RequestService _requestService = RequestService();

  // Método para obtener todos los clientes
  Future<List<ClientModel>> getAll() async {
    final url = 'clientes';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final List<dynamic> responseData = response["body"];
      return responseData.map((data) => ClientModel.fromJson(data)).toList();
    }

    return [];
  }

  // Método para obtener un cliente por su id
  Future<ClientModel?> getById(ClientModel client) async {
    final url = 'clientes/get-cliente-by-id/${client.clienteId}';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final responseData = response["body"];
      return ClientModel.fromJson(responseData);
    }

    return null;
  }

  // Método para crear un cliente
  Future<bool> create(ClientModel client) async {
    final url = 'clientes';
    final response = await _requestService.post(url, client.toJson());

    return response != null && response["statusCode"] == 201;
  }

  // Método para actualizar un cliente
  Future<bool> update(ClientModel client) async {
    final url = 'clientes/${client.clienteId}';
    final response = await _requestService.put(url, client.toJson());

    return response != null && response["statusCode"] == 204;
  }

  // Método para desactivar un cliente
  Future<bool> disable(ClientModel client) async {
    final url = 'clientes/update-cliente-estado/${client.clienteId}';
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
