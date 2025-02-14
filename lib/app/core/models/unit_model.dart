class UnitModel {
  final int unidadId;
  final String? unidadDescripcion;

  UnitModel({
    required this.unidadId,
    this.unidadDescripcion,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      unidadId: json['unidadId'],
      unidadDescripcion: json['unidadDescripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unidadId': unidadId,
      'unidadDescripcion': unidadDescripcion,
    };
  }
}