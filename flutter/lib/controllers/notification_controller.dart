import 'package:at_coffee/models/notification.dart';
import 'package:get/state_manager.dart';
import 'package:at_coffee/services/service_notification.dart';
import 'package:firebase_database/firebase_database.dart';

class NotificationController extends GetxController {
  var notificationsList = <NotificationItem>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> sendNotification(
      NotificationItem notification, String token) async {
    try {
      await RemoteServices.sendNotification(notification, token);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> addNotification(NotificationItem notification) async {
    try {
      var isSuccess = await RemoteServices.addNotification(notification);
      return isSuccess;
    } catch (error) {
      return false;
    }
  }

  Future<void> updateNotification(NotificationItem notification) async {
    try {
      var isSuccess = await RemoteServices.updateNotification(notification);
      return isSuccess;
    } catch (error) {
      return false;
    }
  }

  void getNotifications(int id) {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('notifications/' + id.toString());
    isLoading(true);
    starCountRef.onValue.listen((DatabaseEvent event) {
      List<NotificationItem> notifications = [];
      final data = event.snapshot.value;
      Map<Object, Object> myData = data;
      if (myData != null) {
        myData.forEach((key, values) {
          // print(values);
          var myNotification = NotificationItem.fromDocumentSnapshot(values);
          notifications.insert(0, myNotification);
        });
        notifications.sort((a, b) => b.time.compareTo(a.time));
        notificationsList.value = notifications;
      } else {
        notificationsList.value = [];
      }
    });
    isLoading(false);
  }
}
