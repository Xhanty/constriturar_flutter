import 'package:constriturar/app/core/models/document_type_model.dart';
import 'package:constriturar/app/core/services/request_service.dart';

class DocumentTypeService {
  final RequestService _requestService = RequestService();

  // Método para obtener todos los tipos de documentos
  Future<List<DocumentTypeModel>> getAll() async {
    final url = 'tipos-documentos';
    final response = await _requestService.get(url);

    if (response != null && response["statusCode"] == 200) {
      final List<dynamic> responseData = response["body"];
      return responseData
          .map((data) => DocumentTypeModel.fromJson(data))
          .toList();
    }

    return [];
  }
}
