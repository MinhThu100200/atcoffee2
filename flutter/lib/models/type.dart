import 'dart:convert';

List<Type> typeFromJson(String str) =>
    List<Type>.from(json.decode(str).map((x) => Type.fromJson(x)));

String typeToJson(List<Type> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Type {
  Type(
      {this.id,
      this.createdDate,
      this.modifiedDate,
      this.createdBy,
      this.modifiedBy,
      this.code,
      this.state,
      this.results,
      this.name,
      this.point});
  int id;
  int createdDate;
  int modifiedDate;
  String createdBy;
  String modifiedBy;
  String code;
  bool state;
  List<dynamic> results;
  String name;
  int point;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        code: json["code"],
        state: json["state"],
        results: json["results"],
        name: json["name"],
        point: json["point"],
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
        "point": point,
      };
}
