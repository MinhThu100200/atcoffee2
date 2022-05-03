import 'package:http/http.dart' as http;
import 'package:at_coffee/models/size.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Size>> fetchSizes() async {
    var response = await client.get(Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return sizeFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
