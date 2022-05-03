// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User(
      {this.id,
      this.createdDate,
      this.modifiedDate,
      this.createdBy,
      this.modifiedBy,
      this.code,
      this.state,
      this.results,
      this.username,
      this.password,
      this.image,
      this.file,
      this.name,
      this.phone,
      this.gender,
      this.email,
      this.address,
      this.dob,
      this.identityCard,
      this.storeId,
      this.accumulatedPoints,
      this.currentPoints,
      this.typeId,
      this.roleName});

  int id;
  int createdDate;
  int modifiedDate;
  String createdBy;
  String modifiedBy;
  String code;
  bool state;
  List<dynamic> results;
  String username;
  String password;
  String image;
  dynamic file;
  String name;
  String phone;
  String gender;
  String email;
  String address;
  int dob;
  String identityCard;
  int storeId;
  int accumulatedPoints;
  int currentPoints;
  int typeId;
  String roleName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        code: json["code"],
        state: json["state"],
        results: json["results"],
        username: json["username"],
        password: json["password"],
        image: json["image"],
        file: json["file"],
        name: json["name"],
        phone: json["phone"],
        gender: json["gender"],
        email: json["email"],
        address: json["address"],
        dob: json["dob"],
        identityCard: json["identityCard"],
        storeId: json["storeId"],
        accumulatedPoints: json["accumulatedPoints"],
        currentPoints: json["currentPoints"],
        typeId: json["typeId"],
        roleName: json["roleName"],
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
        "username": username,
        "password": password,
        "image": image,
        "file": file,
        "name": name,
        "phone": phone,
        "gender": gender,
        "email": email,
        "address": address,
        "dob": dob,
        "identityCard": identityCard,
        "storeId": storeId,
        "accumulatedPoints": accumulatedPoints,
        "currentPoints": currentPoints,
        "typeId": typeId,
        "roleName": roleName,
      };
}
