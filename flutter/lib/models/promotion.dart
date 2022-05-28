// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Promotion> promotionFromJson(String str) =>
    List<Promotion>.from(json.decode(str).map((x) => Promotion.fromJson(x)));

String promotionToJson(List<Promotion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Promotion {
  Promotion(
      {this.id,
      this.createdDate,
      this.modifiedDate,
      this.createdBy,
      this.modifiedBy,
      this.code,
      this.state,
      this.results,
      this.name,
      this.image,
      this.description,
      this.discount,
      this.object,
      this.proviso,
      this.startDate,
      this.endDate});

  int id;
  int createdDate;
  int modifiedDate;
  String createdBy;
  String modifiedBy;
  String code;
  bool state;
  List<dynamic> results;
  String name;
  String image;
  String description;
  int discount;
  String object;
  int proviso;
  int startDate;
  int endDate;

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
        id: json["id"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        code: json["code"],
        state: json["state"],
        results: json["results"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        discount: json["discount"],
        object: json["object"],
        proviso: json["proviso"],
        startDate: json["startDate"],
        endDate: json["endDate"],
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
        "image": image,
        "description": description,
        "discount": discount,
        "object": object,
        "proviso": proviso,
        "startDate": startDate,
        "endDate": endDate,
      };
}
