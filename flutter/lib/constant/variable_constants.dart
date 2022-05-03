class VariableConstants {
  static String TOKEN =
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6NDExMDYzODQ1MzAyMzM0NSwiaWF0IjoxNjUxNDEzMDc0fQ.r0KQdwBDJJZ_XThifl5JLgCT-Wg_jH7IBMxd0sN2tfY';

  static API_HEADERS() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + TOKEN,
    };
  }

  static API_PUT_HEADERS() {
    return {
      'Accept': '*/*',
      'Authorization': 'Bearer ' + TOKEN,
    };
  }
}
