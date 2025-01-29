class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeOut = Duration(seconds: 1000);
  static const Duration receiveTimeOut = Duration(seconds: 1000);
  // for android
  //  static const String baseUrl = "http://10.0.2.2:3000/api/v1/";

  // for iphone
  static const String baseUrl = "http://localhost:3000/api/";

  // ========= Auths ===============
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String getAllCustomer = "auth/getAllCustomer";
  static const String getCustomerByProduct = "auth/getCustomerByProduct/";
  static const String getCustomerByOrder = "auth/getCustomerByOrder/";
  static const String updateCustomer = "auth/updateCustomer/";
  static const String deleteCustomer = "auth/deleteCustomer/";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "auth/uploadImage";

  // ======== Products ============

  static const String createProduct = "product/createProduct";
  static const String getAllProduct = "product/getAllProduct";
  static const String deleteProduct = "product/";

  // ======== order  =============
  static const String createOrder = "order/createOrder";
  static const String getAllOrder = "order/getAllOrder";
  static const String deleteOrder = "order/deletebyId";
}
