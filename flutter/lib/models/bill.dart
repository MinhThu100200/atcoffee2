import 'dart:convert';
import 'package:at_coffee/models/bill_detail.dart';

List<Bill> billFromJson(String str) =>
    List<Bill>.from(json.decode(str).map((x) => Bill.fromJson(x)));

String billToJson(List<Bill> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bill {
  Bill(
      {this.id,
      this.createdDate,
      this.modifiedDate,
      this.createdBy,
      this.modifiedBy,
      this.code,
      this.state,
      this.results,
      this.amount,
      this.price,
      this.discount,
      this.point,
      this.address,
      this.status,
      this.rewardId,
      this.promotionId,
      this.paymentId,
      this.staffId,
      this.customerId,
      this.storeId,
      this.billDetails});
  int id;
  int createdDate;
  int modifiedDate;
  String createdBy;
  String modifiedBy;
  String code;
  bool state;
  List<dynamic> results;
  double amount;
  double price;
  int discount;
  int point;
  String address;
  String status;
  int rewardId;
  int promotionId;
  int paymentId;
  int staffId;
  int customerId;
  int storeId;
  List<BillDetail> billDetails;

  // Firebase data
  String promotionCode;
  String paymentName;
  String staffName;
  String customerName;
  bool read;

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
      id: json["id"],
      createdDate: json["createdDate"],
      modifiedDate: json["modifiedDate"],
      createdBy: json["createdBy"],
      modifiedBy: json["modifiedBy"],
      code: json["code"],
      state: json["state"],
      results: json["results"],
      amount: json["amount"],
      price: json["price"],
      discount: json["discount"],
      point: json["point"],
      address: json["address"],
      status: json["status"],
      rewardId: json["rewardId"],
      promotionId: json["promotionId"],
      paymentId: json["paymentId"],
      staffId: json["staffId"],
      customerId: json["customerId"],
      storeId: json["storeId"],
      billDetails: billDetailFromJson(json["billDetails"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "code": code,
        "state": state,
        "results": results,
        "amount": amount,
        "price": price,
        "discount": discount,
        "point": point,
        "address": address,
        "status": status,
        "rewardId": rewardId,
        "promotionId": promotionId,
        "paymentId": paymentId,
        "staffId": staffId,
        "customerId": customerId,
        "storeId": storeId,
        "billDetails": billDetailToJson(billDetails)
      };

  Map<String, dynamic> toFirebaseJson() => {
        "id": id,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "code": code,
        "state": state,
        "results": results,
        "amount": amount,
        "price": price,
        "discount": discount,
        "point": point,
        "address": address,
        "status": status,
        "rewardId": rewardId,
        "promotionId": promotionId,
        "promotionCode": promotionCode,
        "paymentId": paymentId,
        "paymentName": paymentName,
        "staffId": staffId,
        "staffName": staffName,
        "customerId": customerId,
        "customerName": customerName,
        "storeId": storeId,
        "read": read,
        "billDetails": List<dynamic>.from(billDetails.map((x) => x.toJson()))
      };
}
