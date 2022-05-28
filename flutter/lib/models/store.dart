// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Store> storeFromJson(String str) =>
    List<Store>.from(json.decode(str).map((x) => Store.fromJson(x)));

String storeToJson(List<Store> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Store {
  Store(
      {this.id,
      this.createdDate,
      this.modifiedDate,
      this.createdBy,
      this.modifiedBy,
      this.code,
      this.state,
      this.results,
      this.name,
      this.address,
      this.timeOpen,
      this.timeClose,
      this.latitude,
      this.longitude});

  int id;
  int createdDate;
  int modifiedDate;
  String createdBy;
  String modifiedBy;
  String code;
  bool state;
  List<dynamic> results;
  String name;
  String address;
  String timeOpen;
  String timeClose;
  double latitude;
  double longitude;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
      id: json["id"],
      createdDate: json["createdDate"],
      modifiedDate: json["modifiedDate"],
      createdBy: json["createdBy"],
      modifiedBy: json["modifiedBy"],
      code: json["code"],
      state: json["state"],
      results: json["results"],
      name: json["name"],
      address: json["address"],
      timeOpen: json["timeOpen"],
      timeClose: json["timeClose"],
      latitude: json["latitude"],
      longitude: json["longitude"]);

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
        "address": address,
        "timeOpen": timeOpen,
        "timeClose": timeClose,
        "latitude": latitude,
        "longitude": longitude,
      };
}
