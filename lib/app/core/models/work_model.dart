import 'package:constriturar/app/core/models/city_model.dart';
import 'package:constriturar/app/core/models/client_model.dart';
import 'package:constriturar/app/core/models/department_model.dart';

class WorkModel {
  final int obraId;
  final String obraNombre;
  final String telefono;
  final String nombreContacto;
  final String ubicacion;
  final String direccion;
  final List<CityModel> municipio;
  final List<ClientModel> cliente;
  final List<String> empresa;
  final List<DepartmentModel> departamento;

  WorkModel({
    required this.obraId,
    required this.obraNombre,
    required this.telefono,
    required this.nombreContacto,
    required this.ubicacion,
    required this.direccion,
    required this.municipio,
    required this.cliente,
    required this.empresa,
    required this.departamento,
  });

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      obraId: json['obraId'],
      obraNombre: json['obraNombre'],
      telefono: json['telefono'],
      nombreContacto: json['nombreContacto'],
      ubicacion: json['ubicacion'],
      direccion: json['direccion'],
      municipio: List<CityModel>.from(
          json['municipio'].map((x) => CityModel.fromJson(x))),
      cliente: List<ClientModel>.from(
          json['cliente'].map((x) => ClientModel.fromJson(x))),
      empresa: List<String>.from(json['empresa']),
      departamento: List<DepartmentModel>.from(
          json['departamento'].map((x) => DepartmentModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'obraId': obraId,
      'obraNombre': obraNombre,
      'telefono': telefono,
      'nombreContacto': nombreContacto,
      'ubicacion': ubicacion,
      'direccion': direccion,
      'municipio': municipio,
      'cliente': cliente,
      'empresa': empresa,
      'departamento': departamento,
    };
  }
}
