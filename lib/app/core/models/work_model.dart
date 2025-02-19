import 'package:constriturar/app/core/models/business_model.dart';
import 'package:constriturar/app/core/models/city_model.dart';
import 'package:constriturar/app/core/models/client_model.dart';
import 'package:constriturar/app/core/models/department_model.dart';

class WorkModel {
  final int obraId;
  final String? obraNombre;
  final String? telefono;
  final String? nombreContacto;
  final String? ubicacion;
  final String? direccion;
  final CityModel? municipio;
  final ClientModel? cliente;
  final BusinessModel? empresa;
  final DepartmentModel? departamento;

  WorkModel({
    required this.obraId,
    this.obraNombre,
    this.telefono,
    this.nombreContacto,
    this.ubicacion,
    this.direccion,
    this.municipio,
    this.cliente,
    this.empresa,
    this.departamento,
  });

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      obraId: json['obraId'],
      obraNombre: json['obraNombre'],
      telefono: json['telefono'],
      nombreContacto: json['nombreContacto'],
      ubicacion: json['ubicacion'],
      direccion: json['direccion'],
      municipio: CityModel.fromJson(json['municipio']),
      cliente: ClientModel.fromJson(json['cliente']),
      empresa: BusinessModel.fromJson(json['empresa']),
      departamento: DepartmentModel.fromJson(json['departamento']),
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
      'municipio': municipio?.toJson(),
      'cliente': cliente?.toJson(),
      'empresa': empresa,
      'departamento': departamento?.toJson(),
    };
  }
}
