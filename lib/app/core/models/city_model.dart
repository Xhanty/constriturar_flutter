class CityModel {
  final int municipioId;
  final String municipioNombre;

  CityModel({
    required this.municipioId,
    required this.municipioNombre,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      municipioId: json['municipioId'],
      municipioNombre: json['municipioNombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'municipioId': municipioId,
      'municipioNombre': municipioNombre,
    };
  }
}
