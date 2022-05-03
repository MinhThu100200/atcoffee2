// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';
import 'package:get/get.dart';

List<Rate> rateFromJson(String str) =>
    List<Rate>.from(json.decode(str).map((x) => Rate.fromJson(x)));

String rateToJson(List<Rate> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rate {
  Rate(
      {this.id,
      this.createdDate,
      this.modifiedDate,
      this.createdBy,
      this.modifiedBy,
      this.code,
      this.state,
      this.results,
      this.comment,
      this.star,
      this.userId,
      this.productId});

  int id;
  int createdDate;
  int modifiedDate;
  String createdBy;
  String modifiedBy;
  String code;
  bool state;
  List<dynamic> results;
  String comment;
  int star;
  int userId;
  int productId;

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        id: json["id"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        code: json["code"],
        state: json["state"],
        results: json["results"],
        comment: json["comment"],
        star: json["star"],
        userId: json["userId"],
        productId: json["productId"],
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
        "comment": comment,
        "star": star,
        "userId": userId,
        "productId": productId
      };
}
