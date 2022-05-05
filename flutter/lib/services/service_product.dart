import 'package:http/http.dart' as http;
import 'package:at_coffee/models/product.dart';
import 'package:at_coffee/constant/api_constants.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Product>> fetchProducts() async {
    var response = await client
        .get(Uri.parse(ApiConstants.HOST + ApiConstants.GET_PRODUCT));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(response.body);
      return productFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<List<Product>> fetchProductsByCategory(cate) async {
    var response = await client.get(Uri.parse(
        ApiConstants.HOST + ApiConstants.GET_PRODUCT_BY_CATEGORY(cate)));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(response.body);
      return productFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
