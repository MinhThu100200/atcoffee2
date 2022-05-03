import 'package:http/http.dart' as http;
import 'package:at_coffee/models/promotion.dart';
import 'package:at_coffee/constant/api_constants.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Promotion>> fetchPromotions() async {
    var response = await client
        .get(Uri.parse(ApiConstants.HOST + ApiConstants.GET_PROMOTION));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print("promotions" + response.body);
      return promotionFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
