import 'dart:convert';
import 'package:at_coffee/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  Cart(
      {this.id,
      this.createdDate,
      this.modifiedDate,
      this.createdBy,
      this.modifiedBy,
      this.code,
      this.state,
      this.results,
      this.description,
      this.quantity,
      this.sugar,
      this.ice,
      this.milk,
      this.customerId,
      this.productId,
      this.storeId,
      this.size,
      this.product});

  int id;
  int createdDate;
  int modifiedDate;
  String createdBy;
  String modifiedBy;
  String code;
  bool state;
  List<dynamic> results;
  String description;
  int quantity;
  int sugar;
  int ice;
  String milk;
  int customerId;
  int productId;
  int storeId;
  String size;
  Product product;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      id: json["id"],
      createdDate: json["createdDate"],
      modifiedDate: json["modifiedDate"],
      createdBy: json["createdBy"],
      modifiedBy: json["modifiedBy"],
      code: json["code"],
      state: json["state"],
      results: json["results"],
      description: json["description"],
      quantity: json["quantity"],
      sugar: json["sugar"],
      ice: json["ice"],
      milk: json["milk"],
      customerId: json["customerId"],
      productId: json["productId"],
      storeId: json["storeId"],
      size: json["size"],
      product: Product.fromJson(json["product"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "code": code,
        "state": state,
        "results": results,
        "description": description,
        "quantity": quantity,
        "sugar": sugar,
        "ice": ice,
        "milk": milk,
        "customerId": customerId,
        "productId": productId,
        "storeId": storeId,
        "size": size,
        "product": product.toJson(),
      };
}
