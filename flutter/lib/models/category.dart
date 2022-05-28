// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.code,
    this.state,
    this.results,
    this.name,
  });

  int id;
  int createdDate;
  int modifiedDate;
  String createdBy;
  String modifiedBy;
  String code;
  bool state;
  List<dynamic> results;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        code: json["code"],
        state: json["state"],
        results: json["results"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "code": code,
        "state": state,
        "results": results,
        "name": name,
      };
}
