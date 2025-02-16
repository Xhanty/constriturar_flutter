import 'package:constriturar/app/core/models/business_model.dart';

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String estado;
  final BusinessModel? empresa;
  final List<String> roles;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.estado,
    this.empresa,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      estado: json['estado'],
      empresa: json['empresa'] != null ? BusinessModel.fromJson(json['empresa']) : null,
      roles: List<String>.from(json['roles']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'estado': estado,
      'empresa': empresa?.toJson(),
      'roles': roles,
    };
  }
}
