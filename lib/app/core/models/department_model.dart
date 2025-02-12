class DepartmentModel {
  final int departamentoId;
  final String departamentoNombre;

  DepartmentModel({
    required this.departamentoId,
    required this.departamentoNombre,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      departamentoId: json['departamentoId'],
      departamentoNombre: json['departamentoNombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departamentoId': departamentoId,
      'departamentoNombre': departamentoNombre,
    };
  }
}
