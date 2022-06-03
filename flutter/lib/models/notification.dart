import 'dart:convert';

List<NotificationItem> notificationItemFromJson(String str) =>
    List<NotificationItem>.from(
        json.decode(str).map((x) => NotificationItem.fromJson(x)));

// List<Bill> billFromFirebase(dynamic str) =>
//     List<Bill>.from(str.map((x) => Bill.fromDocumentSnapshot(x)));

String notificationItemToFirebaseJson(List<NotificationItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toFirebaseJson())));

class NotificationItem {
  int id;
  String code;
  String codeOrder;
  String title;
  String body;
  bool isSeen;
  int time;

  NotificationItem(
      {this.id,
      this.code,
      this.codeOrder,
      this.title,
      this.body,
      this.isSeen,
      this.time});

  NotificationItem.fromDocumentSnapshot(Map<dynamic, dynamic> json)
      : id = json["id"].toInt(),
        code = json["code"],
        codeOrder = json["codeOrder"],
        title = json["title"],
        body = json["body"],
        isSeen = (json['isSeen'].toString().toLowerCase() ==
            true.toString().toLowerCase()),
        time = json["time"].toInt();

  factory NotificationItem.fromJson(Map<dynamic, dynamic> json) =>
      NotificationItem(
        id: json["id"],
        code: json["code"],
        codeOrder: json["codeOrder"],
        title: json["title"],
        body: json["body"],
        isSeen: json["isSeen"],
        time: json["time"],
      );

  Map<String, dynamic> toFirebaseJson() => {
        "id": id,
        "code": code,
        "codeOrder": codeOrder,
        "title": title,
        "body": body,
        "isSeen": isSeen,
        "time": time
      };
}
