// To parse this JSON data, do
//
//     final bmiDatModel = bmiDatModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class BmiDataModel {
  final String name;
  final String address;
  final String myAge;
  final double bmi;
  final String gender;
  final String heightResults;

  BmiDataModel({
    required this.name,
    required this.address,
    required this.myAge,
    required this.bmi,
    required this.gender,
    required this.heightResults,
  });

  factory BmiDataModel.fromRawJson(String str) => BmiDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BmiDataModel.fromJson(Map<String, dynamic> json) => BmiDataModel(
    name: json["name"],
    address: json["address"],
    myAge: json["myAge"],
    bmi: json["bmi"],
    gender: json["gender"],
    heightResults: json["heightResults"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "myAge": myAge,
    "bmi": bmi,
    "gender": gender,
    "heightResults": heightResults,
  };
}
