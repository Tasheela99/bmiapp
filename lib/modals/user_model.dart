// To parse this JSON data, do
//
//     final bmiDatModel = bmiDatModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String phone;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
  };
}
