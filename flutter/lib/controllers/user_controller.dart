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

  void authUser(String username, String password) async {
    try {
      isLoading(true);
      var userFetched = await RemoteServices.authUser(username, password);
      if (userFetched != null) {
        user.value = userFetched;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<User> authUserByToken() async {
    try {
      isLoading(true);
      var userFetched = await RemoteServices.authUserByToken();
      if (userFetched != null) {
        user.value = userFetched;
        return user.value;
      }
    } finally {
      isLoading(false);
    }
    return null;
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
