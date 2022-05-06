import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:at_coffee/constant/variable_constants.dart';
import 'package:http/http.dart' as http;

Future<bool> setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('token', value);
}

Future<String> getToken() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    return token ?? '';
  } catch (e) {
    return '';
  }
}

Future<bool> removeToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove('token');
}

class ApiService {
  var client;

  static ApiService _instance;
  ApiService._() {
    client = http.Client();
  }

  static ApiService instance() {
    return _instance ?? ApiService._();
  }

  Future<dynamic> get(String url) async {
    String token = await getToken();
    var client = http.Client();
    var response = await client.get(
      Uri.parse(url),
      headers: VariableConstants.API_HEADERS(token),
    );
    return response;
  }

  Future<dynamic> post(String url, dynamic body) async {
    String token = await getToken();
    var response = await client.post(Uri.parse(url),
        headers: VariableConstants.API_HEADERS(token), body: body);
    return response;
  }

  Future<dynamic> put(String url, dynamic body) async {
    String token = await getToken();
    var response = await client.put(Uri.parse(url),
        headers: VariableConstants.API_PUT_HEADERS(token), body: body);
    return response;
  }
}
