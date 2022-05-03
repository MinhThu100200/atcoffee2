import 'package:http/http.dart' as http;
import 'package:at_coffee/models/payment.dart';
import 'package:at_coffee/constant/api_constants.dart';
import 'package:at_coffee/constant/variable_constants.dart';
import 'dart:io';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Payment>> fetchPayments() async {
    var response = await client
        .get(Uri.parse(ApiConstants.HOST + ApiConstants.GET_PAYMENTS));
    if (response.statusCode == 200) {
      print(response.body);
      return paymentFromJson(response.body);
    } else {
      print('fetchPayments: error!');
      return null;
    }
  }
}
