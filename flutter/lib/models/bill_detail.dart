import 'dart:convert';

List<BillDetail> billDetailFromJson(String str) =>
    List<BillDetail>.from(json.decode(str).map((x) => BillDetail.fromJson(x)));

String billDetailToJson(List<BillDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillDetail {
  BillDetail(
      {this.id,
      this.createdDate,
      this.modifiedDate,
      this.createdBy,
      this.modifiedBy,
      this.code,
      this.state,
      this.results,
      this.quantity,
      this.description,
      this.amount,
      this.price,
      this.size,
      this.discount,
      this.billId,
      this.productId});
  int id;
  int createdDate;
  int modifiedDate;
  String createdBy;
  String modifiedBy;
  String code;
  bool state;
  List<dynamic> results;
  int quantity;
  String description;
  double amount;
  double price;
  String size;
  int discount;
  int billId;
  int productId;

  BillDetail.fromMap(Map<dynamic, dynamic> json)
      : id = json["id"],
        createdDate = json["createdDate"],
        modifiedDate = json["modifiedDate"],
        createdBy = json["createdBy"],
        modifiedBy = json["modifiedBy"],
        code = json["code"],
        state = json["state"],
        results = json["results"],
        quantity = json["quantity"],
        description = json["description"],
        amount = json["amount"].toDouble(),
        price = json["price"].toDouble(),
        size = json["size"],
        discount = json["discount"],
        billId = json["billId"],
        productId = json["productId"];
  factory BillDetail.fromJson(Map<String, dynamic> json) => BillDetail(
      id: json["id"],
      createdDate: json["createdDate"],
      modifiedDate: json["modifiedDate"],
      createdBy: json["createdBy"],
      modifiedBy: json["modifiedBy"],
      code: json["code"],
      state: json["state"],
      results: json["results"],
      quantity: json["quantity"],
      description: json["description"],
      amount: json["amount"],
      price: json["price"],
      size: json["size"],
      discount: json["discount"],
      billId: json["billId"],
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
        "quantity": quantity,
        "description": description,
        "amount": amount,
        "price": price,
        "size": size,
        "discount": discount,
        "billId": billId,
        "productId": productId
      };
}
