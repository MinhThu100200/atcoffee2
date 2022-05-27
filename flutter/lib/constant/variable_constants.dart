import 'package:intl/intl.dart';

class VariableConstants {
  static API_HEADERS(String token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token,
    };
  }

  static API_PUT_HEADERS(String token) {
    return {
      'Accept': '*/*',
      'Authorization': 'Bearer ' + token,
    };
  }
}

class MethodConstants {
  static final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');
}

class StatusBillConstants {
  static double POINTS_REFUND = 0.001;
  static String REQUESTED = 'REQUESTED';
  static String APPROVED = 'APPROVED';
  static String UNAPPROVED = 'UNAPPROVED';
  static String PAID = 'PAID';
  static String UNPAID = 'UNPAID';
  static String CANCELED = 'CANCELED';
  static String DELIVERING = 'DELIVERING';
  static String COMPLETED = 'COMPLETED';
}
