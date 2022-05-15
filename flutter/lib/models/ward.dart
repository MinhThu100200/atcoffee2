// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Ward> storeFromJson(String str) =>
    List<Ward>.from(json.decode(str).map((x) => Ward.fromJson(x)));

String storeToJson(List<Ward> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ward {
  Ward({
    this.name,
    this.code,
    this.codename,
    this.division_type,
    this.short_codename,
  });

  String name;
  int code;
  String codename;
  String division_type;
  String short_codename;

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        name: json["name"],
        code: json["code"],
        codename: json["codename"],
        division_type: json["division_type"],
        short_codename: json["short_codename"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "codename": codename,
        "division_type": division_type,
        "short_codename": short_codename,
      };
}
