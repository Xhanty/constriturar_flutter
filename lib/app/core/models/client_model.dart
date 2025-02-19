import 'package:constriturar/app/core/models/business_model.dart';
import 'package:constriturar/app/core/models/document_type_model.dart';
import 'package:constriturar/app/core/models/user_model.dart';

class ClientModel {
  final int clienteId;
  final String? nombres;
  final String? primerApellido;
  final String? segundoApellido;
  final String? nombreCompleto;
  final String? identificacion;
  final String? encargado;
  final DocumentTypeModel? tipoDocumento;
  final UserModel? user;
  final BusinessModel? empresa;
  final String? saldoCliente;

  ClientModel({
    required this.clienteId,
    this.nombres,
    this.primerApellido,
    this.segundoApellido,
    this.nombreCompleto,
    this.identificacion,
    this.encargado,
    this.tipoDocumento,
    this.user,
    this.empresa,
    this.saldoCliente,
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
      tipoDocumento: DocumentTypeModel.fromJson(json['tipoDocumento']),
      user: UserModel.fromJson(json['user']),
      empresa: BusinessModel.fromJson(json['empresa']),
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
      'tipoDocumento': tipoDocumento?.toJson(),
      'user': user?.toJson(),
      'empresa': empresa,
      'saldoCliente': saldoCliente,
    };
  }
}
