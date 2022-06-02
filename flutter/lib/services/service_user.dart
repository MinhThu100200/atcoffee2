import 'package:at_coffee/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:at_coffee/models/store.dart';
import 'package:at_coffee/models/user.dart';
import 'package:at_coffee/constant/api_constants.dart';
import 'dart:convert';
import 'package:at_coffee/common/utils_common/api_service.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Store>> fetchStores() async {
    var response =
        await client.get(Uri.parse(ApiConstants.HOST + ApiConstants.GET_STORE));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      //print(response.body);
      return storeFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<User> authUser(String username, String password) async {
    String url = ApiConstants.HOST + ApiConstants.AUTHORIZATE;
    String body = jsonEncode(
        <String, String>{'username': username, 'password': password});

    var response = await ApiService.instance().post(url, body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      await setToken(json.decode(jsonString)["jwt"]);
      return User.fromJson(json.decode(jsonString)["user"]);
    } else {
      //print('authUser: error');
      return null;
    }
  }

  static Future<User> authUserByToken() async {
    String url = ApiConstants.HOST + ApiConstants.AUTH_USER_BY_TOKEN;
    var response = await ApiService.instance().get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return User.fromJson(json.decode(jsonString));
    } else {
      //print('authUserByToken: error');
      return null;
    }
  }

  static Future<User> updateUser(User user) async {
    var map = <String, dynamic>{};
    map["user"] = jsonEncode(user.toJson());
    String url = ApiConstants.HOST + ApiConstants.UPDATE_USER;
    var response = await ApiService.instance().putForm(url, map);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return User.fromJson(json.decode(jsonString));
    } else {
      //print('updateUser: error');
      return null;
    }
  }

  static Future<String> validateSignUp(User user) async {
    String validateMsg = '';
    try {
      String url = ApiConstants.HOST + ApiConstants.VALIDATE_CUSTOMER_SIGNUP;
      String body = jsonEncode(user.toJson());
      var response = await ApiService.instance().post(url, body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        //print(response.statusCode);
        validateMsg = 'Đã có lỗi xảy ra';
      }
    } catch (e) {
      //print('validateSignUp: error');
      validateMsg = 'Đã có lỗi xảy ra';
    }
    return validateMsg;
  }

  static Future<User> signUp(User user) async {
    try {
      user.image =
          'https://res.cloudinary.com/tranan2509/image/upload/v1638879521/c5dblrhvi0yewfzs6blj.jpg';
      String url = ApiConstants.HOST + ApiConstants.SIGN_UP;
      var map = <String, dynamic>{};
      map["user"] = jsonEncode(user.toJson());
      var response = await ApiService.instance().postForm(url, map);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        return User.fromJson(json.decode(jsonString));
      } else {
        print('signUp: ' + response.statusCode);
        return null;
      }
    } catch (e) {
      print('signUp: error');
      return null;
    }
  }

  static Future<bool> resetPassword(String email) async {
    try {
      String url =
          ApiConstants.HOST + ApiConstants.RESET_PASSWORD + '?email=' + email;
      var response = await ApiService.instance().get(url);
      if (response.statusCode == 200) {
        return response.body.toString().toLowerCase() == 'true';
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> changePassword(
      User user, String oldPassword, String newPassword) async {
    try {
      String url = ApiConstants.HOST + ApiConstants.CHANGE_PASSWORD;
      String body = jsonEncode(<String, dynamic>{
        'user': user.toJson(),
        'oldPassword': oldPassword,
        'newPassword': newPassword
      });
      var response = await ApiService.instance().put(url, body);
      if (response.statusCode == 200) {
        //print(response.body);
        if (json.decode(response.body) != null) {
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Product>> fetchFavourites() async {
    String url = ApiConstants.HOST + ApiConstants.FAVOURITE;

    var response = await ApiService.instance().get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJsonNotPage(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<bool> addFavourites(int productId) async {
    String url = ApiConstants.HOST + ApiConstants.FAVOURITE;
    String body =
        jsonEncode(<String, dynamic>{'customerId': 0, 'productId': productId});
    var response = await ApiService.instance().post(url, body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> removeFavourites(int productId) async {
    String url = ApiConstants.HOST +
        ApiConstants.FAVOURITE +
        '?productId=' +
        productId.toString();
    var response = await ApiService.instance().delete(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
