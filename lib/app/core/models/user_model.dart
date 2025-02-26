import 'package:constriturar/app/core/models/business_model.dart';

class UserModel {
  late String? id;
  final String? userName;
  late String? password;
  final String? email;
  final String? phoneNumber;
  final String? estado;
  final BusinessModel? empresa;
  final List<String>? roles;

  UserModel({
    this.id,
    this.userName,
    this.password,
    this.email,
    this.phoneNumber,
    this.estado,
    this.empresa,
    this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['userName'],
      password: json['password'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      estado: json['estado'],
      empresa: json['empresa'] != null
          ? BusinessModel.fromJson(json['empresa'])
          : null,
      roles: List<String>.from(json['roles']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'email': email,
      'phoneNumber': phoneNumber,
      'estado': estado,
      'empresa': empresa?.toJson(),
      'roles': roles,
    };
  }
}
