import 'package:at_coffee/common/utils_common/api_service.dart';
import 'package:at_coffee/models/notification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class RemoteServices {
  // DatabaseReference ref = FirebaseDatabase.instance.ref();

  static Future<void> addNotification(NotificationItem notification) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("notifications/" +
        notification.id.toString() +
        '/' +
        notification.code);

    await ref.set(notification.toFirebaseJson());
  }

  static Future<void> updateNotification(NotificationItem notification) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("notifications/" +
        notification.id.toString() +
        '/' +
        notification.code);

    await ref.set(notification.toFirebaseJson());
  }

  static Future<bool> sendNotification(
      NotificationItem notification, String token) async {
    try {
      String url = 'https://fcm.googleapis.com/fcm/send';
      String body = jsonEncode(<String, String>{
        'to': token,
        'notification': jsonEncode(notification.toFirebaseJson())
      });

      var response = await ApiService.instance().postNotification(url, body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
