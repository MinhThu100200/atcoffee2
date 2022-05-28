// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Size> sizeFromJson(String str) =>
    List<Size>.from(json.decode(str).map((x) => Size.fromJson(x)));

String sizeToJson(List<Size> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Size {
  Size({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.code,
    this.state,
    this.results,
    this.size,
    this.price,
    this.productId,
  });

  int id;
  int createdDate;
  int modifiedDate;
  String createdBy;
  String modifiedBy;
  dynamic code;
  bool state;
  List<dynamic> results;
  String size;
  double price;
  int productId;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
      id: json["id"],
      createdDate: json["createdDate"],
      modifiedDate: json["modifiedDate"],
      createdBy: json["createdBy"],
      modifiedBy: json["modifiedBy"],
      code: json["code"],
      state: json["state"],
      results: json["results"],
      size: json["size"],
      price: json["price"],
      productId: json["productId"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "code": code,
        "state": state,
        "results": results,
        "size": size,
        "price": price,
        "productId": productId,
      };
}
