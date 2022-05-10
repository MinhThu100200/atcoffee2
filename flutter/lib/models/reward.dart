// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';
import 'package:get/get.dart';

List<Reward> rewardFromJson(String str) {
  return List<Reward>.from(json.decode(str).map((x) => Reward.fromJson(x)));
}

String rewardToJson(List<Reward> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reward {
  Reward({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.code,
    this.state,
    this.results,
    this.name,
    this.proviso,
    this.redution,
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
  int proviso;
  int redution;

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        id: json["id"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        code: json["code"],
        state: json["state"],
        results: json["results"],
        name: json["name"],
        proviso: json["proviso"],
        redution: json["redution"],
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
        "proviso": proviso,
        "redution": redution,
      };
}
