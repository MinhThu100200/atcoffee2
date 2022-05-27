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

  Future<void> authUser(String username, String password) async {
    try {
      isLoading.value = true;
      var userFetched = await RemoteServices.authUser(username, password);
      if (userFetched != null) {
        user.value = userFetched;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<User> authUserByToken() async {
    try {
      isLoading.value = true;
      var userFetched = await RemoteServices.authUserByToken();
      if (userFetched != null) {
        user.value = userFetched;
        return user.value;
      }
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<bool> updateUser(User userUpdate) async {
    try {
      isLoading.value = true;
      var userFetched = await RemoteServices.updateUser(userUpdate);
      if (userFetched != null) {
        user.value = userFetched;
        return true;
      }
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  Future<User> signUp(User userAdd) async {
    try {
      isLoading.value = true;
      var userFetched = await RemoteServices.signUp(userAdd);
      if (userFetched != null) {
        user.value = userFetched;
        return user.value;
      }
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<String> validateSignUp(User userAdd) async {
    String errorMsg = '';
    try {
      errorMsg = await RemoteServices.validateSignUp(userAdd);
      return errorMsg;
    } catch (e) {
      errorMsg = 'Đã có lỗi xảy ra';
      return errorMsg;
    }
  }

  Future<bool> resetPassword(String emailReset) async {
    try {
      isLoading.value = true;
      var isSuccess = await RemoteServices.resetPassword(emailReset);
      if (isSuccess != null) {
        return isSuccess;
      }
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      isLoading.value = true;
      bool isSuccess = await RemoteServices.changePassword(
          user.value, oldPassword, newPassword);
      return isSuccess;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
