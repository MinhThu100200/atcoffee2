import 'package:at_coffee/common/utils_common/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:at_coffee/models/reward.dart';
import 'package:at_coffee/constant/api_constants.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Reward>> fetchRewards() async {
    String url = ApiConstants.HOST + ApiConstants.GET_REWARD;
    var response = await ApiService.instance().get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);
      return rewardFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
