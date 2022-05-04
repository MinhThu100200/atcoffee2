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
