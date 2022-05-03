import 'package:http/http.dart' as http;
import 'package:at_coffee/models/reward.dart';
import 'package:at_coffee/constant/api_constants.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Reward>> fetchRewards() async {
    var response = await client
        .get(Uri.parse(ApiConstants.HOST + ApiConstants.GET_REWARD));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print("reaward" + response.body);
      return rewardFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
