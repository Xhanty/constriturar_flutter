class DocumentTypeModel {
  final int tipoDocumentoId;
  final String tipoDocumentoDescripcion;

  DocumentTypeModel({
    required this.tipoDocumentoId,
    required this.tipoDocumentoDescripcion,
  });

  factory DocumentTypeModel.fromJson(Map<String, dynamic> json) {
    return DocumentTypeModel(
      tipoDocumentoId: json['tipoDocumentoId'],
      tipoDocumentoDescripcion: json['tipoDocumentoDescripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipoDocumentoId': tipoDocumentoId,
      'tipoDocumentoDescripcion': tipoDocumentoDescripcion,
    };
  }
}
