import 'dart:convert';

List<Payment> paymentFromJson(String str) =>
    List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String PaymentToJson(List<Payment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payment {
  int id;
  int createdDate;
  int modifiedDate;
  String createdBy;
  String modifiedBy;
  String code;
  bool state;
  String name;

  Payment(
      {this.id,
      this.createdDate,
      this.modifiedDate,
      this.createdBy,
      this.modifiedBy,
      this.code,
      this.state,
      this.name});

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
      id: json["id"],
      createdDate: json["createdDate"],
      modifiedDate: json["modifiedDate"],
      createdBy: json["createdBy"],
      modifiedBy: json["modifiedBy"],
      code: json["code"],
      state: json["state"],
      name: json["name"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "code": code,
        "state": state,
        "name": name,
      };
}
