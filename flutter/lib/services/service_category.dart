import 'package:http/http.dart' as http;
import 'package:at_coffee/models/category.dart';
import 'package:at_coffee/constant/api_constants.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Category>> fetchCategories() async {
    var response = await client
        .get(Uri.parse(ApiConstants.HOST + ApiConstants.GET_CATEGORY));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      //print(response.body);
      return categoryFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
