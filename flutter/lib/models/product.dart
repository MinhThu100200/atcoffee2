// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';
import 'package:at_coffee/models/category.dart';
import 'package:at_coffee/models/store.dart';
import 'package:at_coffee/models/size.dart';

List<Product> productFromJson(String str) {
  final data = json.decode(str)['products'];
  return List<Product>.from(data.map((x) => Product.fromJson(x)));
}

List<Product> productFromJsonNotPage(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.code,
    this.state,
    this.results,
    this.name,
    this.image,
    this.file,
    this.description,
    this.discount,
    this.rate,
    this.milk,
    this.numberReviewers,
    this.categories,
    this.stores,
    this.sizes,
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
  String image;
  dynamic file;
  String description;
  int discount;
  double rate;
  bool milk;
  int numberReviewers;
  List<Category> categories;
  List<Store> stores;
  List<Size> sizes;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        file: json["file"],
        description: json["description"],
        discount: json["discount"],
        rate: json["rate"],
        milk: json["milk"],
        numberReviewers: json["numberReviewers"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        stores: List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
        sizes: List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
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
        "file": file,
        "description": description,
        "discount": discount,
        "rate": rate,
        "milk": milk,
        "numberReviewers": numberReviewers,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
        "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
      };
}
