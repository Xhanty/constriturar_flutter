import 'package:constriturar/app/core/models/unit_model.dart';

class MaterialModel {
  final int materialId;
  final String? materialNombre;
  final String? normaTecnica;
  final double? valorBase;
  final UnitModel? unidad;
  final int? unidadId;

  MaterialModel({
    required this.materialId,
    this.materialNombre,
    this.normaTecnica,
    this.valorBase,
    this.unidad,
    this.unidadId,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      materialId: json['materialId'],
      materialNombre: json['materialNombre'],
      normaTecnica: json['normaTecnica'],
      valorBase: json['valorBase'],
      unidad: UnitModel.fromJson(json['unidad']),
      unidadId: json['unidad']['unidadId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'materialId': materialId,
      'materialNombre': materialNombre,
      'normaTecnica': normaTecnica,
      'valorBase': valorBase,
      'unidad': unidad?.toJson(),
      'unidadId': unidadId,
    };
  }
}
