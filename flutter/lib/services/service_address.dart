import 'package:at_coffee/models/ward.dart';
import 'package:http/http.dart' as http;
import 'package:at_coffee/models/city.dart';
import 'package:at_coffee/models/district.dart';
import 'package:at_coffee/constant/api_constants.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<City>> fetchAddress() async {
    var response = await client.get(Uri.parse(ApiConstants.GET_ADRRESS(3)));
    if (response.statusCode == 200) {
      var jsonString = response.bodyBytes;
      //print("my address in here");
      //print(response.body);
      return cityFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<List<City>> fetchCity() async {
    var response = await client.get(Uri.parse(ApiConstants.GET_ADRRESS(1)));
    if (response.statusCode == 200) {
      var jsonString = response.bodyBytes;
      //print("my city in here");
      //print(response.body);
      return cityFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<List<District>> fetchDistrict() async {
    var response = await client.get(Uri.parse(ApiConstants.GET_ADRRESS(2)));
    if (response.statusCode == 200) {
      var jsonString = response.bodyBytes;
      //print("my distrcit in here");
      //print(response.body);
      return districtFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<List<Ward>> fetchWard() async {
    var response = await client.get(Uri.parse(ApiConstants.GET_ADRRESS(3)));
    if (response.statusCode == 200) {
      var jsonString = response.bodyBytes;
      //print("my ward in here");
      //print(response.body);
      return wardFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
