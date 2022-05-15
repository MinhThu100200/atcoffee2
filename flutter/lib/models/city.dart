// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:at_coffee/models/district.dart';

List<City> storeFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String storeToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    this.name,
    this.code,
    this.codename,
    this.division_type,
    this.phone_code,
    this.districts,
  });

  String name;
  int code;
  String codename;
  String division_type;
  int phone_code;
  List<District> districts;

  factory City.fromJson(Map<String, dynamic> json) => City(
      name: json["name"],
      code: json["code"],
      codename: json["codename"],
      division_type: json["division_type"],
      phone_code: json["phone_code"],
      districts: List<District>.from(
          json["districts"].map((x) => District.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "codename": codename,
        "division_type": division_type,
        "phone_code": phone_code,
        "districts": List<dynamic>.from(districts.map((x) => x.toJson())),
      };
}
