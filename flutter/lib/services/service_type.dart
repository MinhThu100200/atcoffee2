import 'package:at_coffee/models/type.dart';
import 'package:at_coffee/constant/api_constants.dart';
import 'package:at_coffee/common/utils_common/api_service.dart';

class RemoteServices {
  static Future<List<Type>> fetchTypes() async {
    try {
      String url = ApiConstants.HOST + ApiConstants.FETCH_TYPES;

      var response = await ApiService.instance().get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return typeFromJson(jsonString);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
