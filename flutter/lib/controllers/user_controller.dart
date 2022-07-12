import 'package:at_coffee/models/product.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/state_manager.dart';
import 'package:at_coffee/models/user.dart';
import 'package:at_coffee/services/service_user.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  // current user login
  var user = User().obs;
  // favourites
  var favourites = List<Product>().obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Method check login
  Future<void> authUser(String username, String password) async {
    try {
      isLoading.value = true;
      var userFetched = await RemoteServices.authUser(username, password);
      if (userFetched != null) {
        user.value = userFetched;
        String token = await FirebaseMessaging.instance.getToken();
        if (userFetched.token != token) {
          var updatedToken = await RemoteServices.updateTokenDevice(token);
          if (updatedToken != null) {
            user.value.token = token;
          }
        }
        isLoading.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  // check login by token
  Future<User> authUserByToken() async {
    try {
      isLoading.value = true;
      // get user by token
      var userFetched = await RemoteServices.authUserByToken();
      // token is valid
      if (userFetched != null) {
        user.value = userFetched;
        return user.value;
      }
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  // update user information
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

  Future<List<Product>> fetchFavourites() async {
    try {
      isLoading.value = true;
      var products = await RemoteServices.fetchFavourites();
      if (products != null) {
        favourites.value = products;
      }
      return products;
    } catch (e) {
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addFavourites(Product product) async {
    try {
      isLoading.value = true;
      // previous favourites -- use rollback
      var prevFavourites = productFromJsonNotPage(productToJson(favourites));
      // add to list
      favourites.add(product);
      var isSuccess = await RemoteServices.addFavourites(product.id);
      if (isSuccess) {
        fetchFavourites();
        return true;
      } else {
        // rollback favourite
        favourites.value = prevFavourites;
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> removeFavourites(Product product) async {
    try {
      isLoading.value = true;
      var prevFavourites = productFromJsonNotPage(productToJson(favourites));
      favourites.removeWhere((p) => p.id == product.id);
      var isSuccess = await RemoteServices.removeFavourites(product.id);
      if (isSuccess) {
        fetchFavourites();
        return true;
      } else {
        // rollback favourite
        favourites.value = prevFavourites;
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // check favourite of product
  bool checkFavourite(Product product) {
    print(favourites.length);

    // is Favourited
    var check = favourites.any((f) => f.id == product.id);
    return check;
  }
}
