// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:at_coffee/models/ward.dart';

List<District> storeFromJson(String str) =>
    List<District>.from(json.decode(str).map((x) => District.fromJson(x)));

String storeToJson(List<District> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class District {
  District({
    this.name,
    this.code,
    this.codename,
    this.division_type,
    this.short_codename,
    this.wards,
  });

  String name;
  int code;
  String codename;
  String division_type;
  String short_codename;
  List<Ward> wards;

  factory District.fromJson(Map<String, dynamic> json) => District(
        name: json["name"],
        code: json["code"],
        codename: json["codename"],
        division_type: json["division_type"],
        short_codename: json["short_codename"],
        wards: List<Ward>.from(json["wards"].map((x) => Ward.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "codename": codename,
        "division_type": division_type,
        "short_codename": short_codename,
        "wards": List<dynamic>.from(wards.map((x) => x.toJson())),
      };
}
