class ApiConstants {
  static String HOST =
      'https://c0e6-2401-d800-fbbe-ec2d-3c75-c8ff-cacb-c7d6.ap.ngrok.io';

  static String FCM_TOKEN =
      'AAAA-YQwquE:APA91bGUSX9_WqJauv3VE2AECILzW-NNUWEt_h8D8IcsednX6eMUSAR465RtKwDAa_WqGQ34SYwMHz8Xbg8sjdsf9149t_iJn1ZZEogZOmnYzsHocg21fyiDLLYxMpeLQUff2AF_qw9Z';

  static String GET_CATEGORY = '/api/info/category/?list=true';
  static String GET_STORE = '/api/info/store';
  static String GET_ADRRESS(depth) =>
      'https://provinces.open-api.vn/api/?depth=' + depth.toString();
  static String GET_PRODUCT =
      '/api/info/product?page=1&size=100&store=&category&keyword';
  static String GET_PRODUCT_BY_CATEGORY(cate) =>
      '/api/info/product?page=1&size=100&store=AT_THUDUC&category=' +
      cate +
      '&keyword';
  static String GET_REWARD = '/api/info/reward';
  static String GET_PROMOTION = "/api/info/promotion?list=true";
  static String GET_SUGGESTION(customerId, size) =>
      '/api/user/product/suggestion?customerId=' +
      customerId.toString() +
      '&num=' +
      size.toString();
  //Rate
  static String GET_RATE = '/api/info/rate';
  static String GET_RATE_BY_PRODUCT(id) =>
      '/api/info/rate?productId=' + id.toString();
  static String GET_RATE_BY_USER = '/api/user/rate';
  static String ADD_RATE = '/api/user/rate';

  // Api Cart
  static String GET_CARTS_BY_CUSOMTERID(id) =>
      '/api/user/cart?customerId=' + id.toString();
  static String UPDATE_CART = '/api/user/cart';
  static String ADD_CART = '/api/user/cart';
  static String DELETE_CART = '/api/user/cart';
  static String DELETE_CART_BY_USER_ID = '/api/user/cart';
  static String DELETE_CART_PAYMENT = '/api/user/cart/delete';

  // Api Type
  static String FETCH_TYPES = '/api/info/type';

  // Api Reward
  static String FETCH_REWARDS = '/api/info/reward';

  // Api Payment
  static String GET_PAYMENTS = '/api/info/payment';

  // Api User
  static String AUTHORIZATE = '/api/authenticate';
  static String UPDATE_USER = '/api/info/user';
  static String AUTH_USER_BY_TOKEN = '/api/user/authenticate';
  static String SIGN_UP = '/api/info/user';
  static String VALIDATE_CUSTOMER_SIGNUP = "/api/info/customer/validate";
  static String RESET_PASSWORD = '/api/info/reset-password';
  static String CHANGE_PASSWORD = '/api/user/change-password';
  static String FAVOURITE = '/api/user/favourite';
  static String UPDATE_TOKEN = '/api/user/token';
}
