class ApiConstants {
  static String HOST = 'https://5c15-116-108-122-110.ngrok.io';
  static String GET_CATEGORY = '/api/info/category/?list=true';
  static String GET_STORE = '/api/info/store';
  static String GET_PRODUCT =
      '/api/info/product?page=1&size=100&store=AT_THUDUC&category&keyword';
  static String GET_PRODUCT_BY_CATEGORY(cate) =>
      '/api/info/product?page=1&size=100&store=AT_THUDUC&category=' +
      cate +
      '&keyword';
  static String GET_REWARD =
      '/api/staff/reward?page=1&size=1000&keyword&state=true';
  static String GET_PROMOTION = "/api/info/promotion?list=true";
  static String GET_RATE = '/api/info/rate';
  static String GET_RATE_BY_PRODUCT(id) =>
      '/api/info/rate?productId=' + id.toString();

  // Api Cart
  static String GET_CARTS_BY_CUSOMTERID(id) =>
      '/api/user/cart?customerId=' + id.toString();

  // Api Payment
  static String GET_PAYMENTS = '/api/info/payment';

  // Api User
  static String AUTHORIZATE = '/api/authenticate';
  static String UPDATE_USER = '/api/info/user';
  static String AUTH_USER_BY_TOKEN = '/api/user/authenticate';
}
