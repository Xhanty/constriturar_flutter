import 'package:constriturar/app/core/models/unit_model.dart';

class MaterialModel {
  final int materialId;
  final String materialNombre;
  final String normaTecnica;
  final double valorBase;
  final UnitModel unidad;

  MaterialModel({
    required this.materialId,
    required this.materialNombre,
    required this.normaTecnica,
    required this.valorBase,
    required this.unidad,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      materialId: json['materialId'],
      materialNombre: json['materialNombre'],
      normaTecnica: json['normaTecnica'],
      valorBase: json['valorBase'],
      unidad: UnitModel.fromJson(json['unidad']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'materialId': materialId,
      'materialNombre': materialNombre,
      'normaTecnica': normaTecnica,
      'valorBase': valorBase,
      'unidad': unidad.toJson(),
    };
  }
}
