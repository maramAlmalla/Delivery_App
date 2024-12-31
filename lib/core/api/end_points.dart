class EndPoint {
  static String baseUrl = "http://192.168.1.8:8000/api/";
  static String signIn = "login";
  static String signUp = "register";
  static String logout = "logout";
  static String categories = "categories";
  static String forgotPassword = "forgot-password";
  static String resetPassword = "reset-password";

  static String createCart = "${baseUrl}carts";

  static String getUserDataEndPoint(id) {
    return "users/$id";
  }

  static String updateUserDataEndPoint(id) {
    return "users/update/$id";
  }

  static String getMarkets() {
    return "markets";
  }

  static String topRatedProducts = "product/toprate";

  static String getTopRatedProductsUrl({int limit = 10}) {
    return "$baseUrl$topRatedProducts?limit=$limit";
  }

  static String getTopRatedMarkets({int limit = 5}) {
    return "market/toprate?limit=$limit";
  }

  static String getCategories() {
    return "categories";
  }

  static String carts = "${baseUrl}carts";
  static String cartItems = "${baseUrl}cart-items";

  static String getCartItemById(int id) {
    return "$cartItems/$id";
  }

  static String getProductDetails(int productId) {
    return "${baseUrl}products/$productId";
  }

  static String getCartById(int cartId) {
    return "${baseUrl}carts/$cartId";
  }
}

class ApiKey {
  static String phoneNumber = "phoneNumber";
  static String status = "status";
  static String errorMessage = "ErrorMessage";
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String confirmPassword = "confirmPassword";
  static String name = "name";
  static String id = "id";
  static String message = "message";
  static String profilePic = "img";
  static String lastName = "lastName";
  static String phone = "phone";
  static String identifier = "identifier";
  static String location = "location";
}
