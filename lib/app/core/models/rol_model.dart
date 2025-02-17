class RolModel {
  final String role;

  RolModel({
    required this.role,
  });

  factory RolModel.fromJson(Map<String, dynamic> json) {
    return RolModel(
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
    };
  }

  static List<RolModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => RolModel(role: json)).toList();
  }
}