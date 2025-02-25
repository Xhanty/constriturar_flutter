import 'package:constriturar/app/core/models/business_model.dart';
import 'package:constriturar/app/core/models/city_model.dart';
import 'package:constriturar/app/core/models/client_model.dart';
import 'package:constriturar/app/core/models/department_model.dart';

class WorkModel {
  final int obraId;
  final int? clienteId;
  final int? empresaId;
  final String? obraNombre;
  final String? telefono;
  final String? nombreContacto;
  final String? ubicacion;
  final int? departamentoId;
  final int? municipioId;
  final String? direccion;
  final CityModel? municipio;
  final ClientModel? cliente;
  final BusinessModel? empresa;
  final DepartmentModel? departamento;

  WorkModel({
    required this.obraId,
    this.clienteId,
    this.empresaId,
    this.obraNombre,
    this.telefono,
    this.nombreContacto,
    this.ubicacion,
    this.departamentoId,
    this.municipioId,
    this.direccion,
    this.municipio,
    this.cliente,
    this.empresa,
    this.departamento,
  });

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      obraId: json['obraId'],
      clienteId: json['clienteId'],
      empresaId: json['empresaId'],
      obraNombre: json['obraNombre'],
      telefono: json['telefono'],
      nombreContacto: json['nombreContacto'],
      ubicacion: json['ubicacion'],
      departamentoId: json['departamentoId'],
      municipioId: json['municipioId'],
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
      'clienteId': clienteId,
      'empresaId': empresaId,
      'obraNombre': obraNombre,
      'telefono': telefono,
      'nombreContacto': nombreContacto,
      'ubicacion': ubicacion,
      'municipioId': municipioId,
      'direccion': direccion,
      'departamentoId': departamentoId,
      'municipio': municipio?.toJson(),
      'cliente': cliente?.toJson(),
      'empresa': empresa,
      'departamento': departamento?.toJson(),
    };
  }
}
