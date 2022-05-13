import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:at_coffee/models/cart.dart';
import 'package:at_coffee/constant/api_constants.dart';
import 'package:at_coffee/constant/variable_constants.dart';
import 'package:at_coffee/common/utils_common/api_service.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Cart>> fetchCartsByCustomerId(id) async {
    String url = ApiConstants.HOST + ApiConstants.GET_CARTS_BY_CUSOMTERID(id);
    var response = await ApiService.instance().get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return cartFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<Cart> updateCart(Cart cart) async {
    try {
      String url = ApiConstants.HOST + ApiConstants.UPDATE_CART;
      String body = jsonEncode(cart.toJson());
      var response = await ApiService.instance().put(url, body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body) != null) {
          return Cart.fromJson(jsonDecode(response.body));
        }
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Cart> addCart(Cart cart) async {
    try {
      String url = ApiConstants.HOST + ApiConstants.UPDATE_CART;
      String body = jsonEncode(cart.toJson());
      var response = await ApiService.instance().post(url, body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body) != null) {
          return Cart.fromJson(jsonDecode(response.body));
        }
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteCart(int cartId) async {
    try {
      String url = ApiConstants.HOST +
          ApiConstants.DELETE_CART +
          '?cartId=' +
          cartId.toString();
      var response = await ApiService.instance().delete(url);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteCartByUserId(int userId) async {
    try {
      String url = ApiConstants.HOST +
          ApiConstants.DELETE_CART +
          '?userId=' +
          userId.toString();
      var response = await ApiService.instance().delete(url);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteCartPayment(List<int> ids) async {
    try {
      String url = ApiConstants.HOST + ApiConstants.DELETE_CART_PAYMENT;
      String body = jsonEncode(<String, dynamic>{
        'ids': jsonEncode(ids),
      });
      var response = await ApiService.instance().post(url, body);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
