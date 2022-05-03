import 'package:get/state_manager.dart';
import 'package:at_coffee/models/user.dart';
import 'package:at_coffee/services/service_user.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var user = new User().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchUser(String username, String password) async {
    try {
      isLoading(true);
      var userFetched = await RemoteServices.fetchUser(username, password);
      if (userFetched != null) {
        user.value = userFetched;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<bool> updateUser(User userUpdate) async {
    try {
      isLoading(true);
      var userFetched = await RemoteServices.updateUser(userUpdate);
      if (userFetched != null) {
        user.value = userFetched;
        return true;
      }
    } finally {
      isLoading(false);
    }
    return false;
  }
}
