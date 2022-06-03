import 'dart:convert';

import 'package:at_coffee/common/utils_common/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:at_coffee/models/rate.dart';
import 'package:at_coffee/constant/api_constants.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Rate>> fetchRates(id) async {
    var response = await client.get(
        Uri.parse(ApiConstants.HOST + ApiConstants.GET_RATE_BY_PRODUCT(id)));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      //(response.body);
      return rateFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<List<Rate>> fetchRateByUser() async {
    var response = await ApiService.instance()
        .get(ApiConstants.HOST + ApiConstants.GET_RATE_BY_USER);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print("rate user " + jsonString);
      return rateFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<bool> addRate(body) async {
    String url = ApiConstants.HOST + ApiConstants.ADD_RATE;
    var response = await ApiService.instance().post(url, jsonEncode(body));
    if (response.statusCode == 200) {
      //print("rate user " + jsonString);
      return true;
    } else {
      //show error message
      return false;
    }
  }
}
