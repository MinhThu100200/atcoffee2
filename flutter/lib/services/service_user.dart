import 'package:http/http.dart' as http;
import 'package:at_coffee/models/store.dart';
import 'package:at_coffee/models/user.dart';
import 'package:at_coffee/constant/api_constants.dart';
import 'package:at_coffee/constant/variable_constants.dart';
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
      print('authUser: error');
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
      print('authUserByToken: error');
      return null;
    }
  }

  static Future<User> updateUser(User user) async {
    var map = new Map<String, dynamic>();
    map["user"] = jsonEncode(user.toJson());
    String url = ApiConstants.HOST + ApiConstants.UPDATE_USER;
    var response = await ApiService.instance().put(url, map);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return User.fromJson(json.decode(jsonString));
    } else {
      print('updateUser: error');
      return null;
    }
  }
}
