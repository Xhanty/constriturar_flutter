class BusinessModel {
  final int empresaId;
  final String nombre;
  final String codigo;

  BusinessModel({
    required this.empresaId,
    required this.nombre,
    required this.codigo,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      empresaId: json['empresaId'],
      nombre: json['nombre'],
      codigo: json['codigo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'empresaId': empresaId,
      'nombre': nombre,
      'codigo': codigo,
    };
  }
}
