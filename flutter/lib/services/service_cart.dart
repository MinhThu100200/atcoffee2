import 'package:http/http.dart' as http;
import 'package:at_coffee/models/cart.dart';
import 'package:at_coffee/constant/api_constants.dart';
import 'package:at_coffee/constant/variable_constants.dart';
import 'dart:io';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Cart>> fetchCartsByCustomerId(id) async {
    var response = await client.get(
      Uri.parse(ApiConstants.HOST + ApiConstants.GET_CARTS_BY_CUSOMTERID(id)),
      headers: VariableConstants.API_HEADERS(),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return cartFromJson(jsonString);
    } else {
      return null;
    }
  }
}
