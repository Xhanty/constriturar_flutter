class VehicleModel {
  final int vehiculoId;
  final String vehiculoDescripcion;
  final String capacidad;
  final String fechaVenceSoat;
  final String fechaVenceTecno;
  final String modelo;
  final String marca;
  final String placa;

  VehicleModel({
    required this.vehiculoId,
    required this.vehiculoDescripcion,
    required this.capacidad,
    required this.fechaVenceSoat,
    required this.fechaVenceTecno,
    required this.modelo,
    required this.marca,
    required this.placa,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      vehiculoId: json['vehiculoId'],
      vehiculoDescripcion: json['vehiculoDescripcion'],
      capacidad: json['capacidad'],
      fechaVenceSoat: json['fechaVenceSoat'],
      fechaVenceTecno: json['fechaVenceTecno'],
      modelo: json['modelo'],
      marca: json['marca'],
      placa: json['placa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehiculoId': vehiculoId,
      'vehiculoDescripcion': vehiculoDescripcion,
      'capacidad': capacidad,
      'fechaVenceSoat': fechaVenceSoat,
      'fechaVenceTecno': fechaVenceTecno,
      'modelo': modelo,
      'marca': marca,
      'placa': placa,
    };
  }
}
