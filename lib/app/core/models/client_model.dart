import 'package:constriturar/app/core/models/document_type_model.dart';
import 'package:constriturar/app/core/models/user_model.dart';

class ClientModel {
  final int clienteId;
  final String nombres;
  final String primerApellido;
  final String segundoApellido;
  final String nombreCompleto;
  final String identificacion;
  final String encargado;
  final List<DocumentTypeModel> tipoDocumento;
  final List<UserModel> user;
  final List<String> empresa;
  final String saldoCliente;

  ClientModel({
    required this.clienteId,
    required this.nombres,
    required this.primerApellido,
    required this.segundoApellido,
    required this.nombreCompleto,
    required this.identificacion,
    required this.encargado,
    required this.tipoDocumento,
    required this.user,
    required this.empresa,
    required this.saldoCliente,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      clienteId: json['clienteId'],
      nombres: json['nombres'],
      primerApellido: json['primerApellido'],
      segundoApellido: json['segundoApellido'],
      nombreCompleto: json['nombreCompleto'],
      identificacion: json['identificacion'],
      encargado: json['encargado'],
      tipoDocumento: List<DocumentTypeModel>.from(
          json['tipoDocumento'].map((x) => DocumentTypeModel.fromJson(x))),
      user:
          List<UserModel>.from(json['user'].map((x) => UserModel.fromJson(x))),
      empresa: List<String>.from(json['empresa']),
      saldoCliente: json['saldoCliente'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clienteId': clienteId,
      'nombres': nombres,
      'primerApellido': primerApellido,
      'segundoApellido': segundoApellido,
      'nombreCompleto': nombreCompleto,
      'identificacion': identificacion,
      'encargado': encargado,
      'tipoDocumento': tipoDocumento,
      'user': user,
      'empresa': empresa,
      'saldoCliente': saldoCliente,
    };
  }
}
