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
      print(response.body);
      return rateFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
