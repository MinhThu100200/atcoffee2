import 'package:http/http.dart' as http;
import 'package:at_coffee/models/store.dart';
import 'package:at_coffee/models/user.dart';
import 'package:at_coffee/constant/api_constants.dart';
import 'package:at_coffee/constant/variable_constants.dart';
import 'dart:convert';

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

  static Future<User> fetchUser(String username, String password) async {
    var response = await client.post(
      Uri.parse(ApiConstants.HOST + ApiConstants.AUTHORIZATE),
      headers: VariableConstants.API_HEADERS(),
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return User.fromJson(json.decode(jsonString)["user"]);
    } else {
      print('fetchUser: error');
      return null;
    }
  }

  static Future<User> updateUser(User user) async {
    var map = new Map<String, dynamic>();
    map["user"] = jsonEncode(user.toJson());

    var response = await client.put(
      Uri.parse(ApiConstants.HOST + ApiConstants.UPDATE_USER),
      headers: VariableConstants.API_PUT_HEADERS(),
      body: map,
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return User.fromJson(json.decode(jsonString));
    } else {
      print('updateUser: error');
      return null;
    }
  }
}
