class EndPoint {
  // static String baseUrl = "http://192.168.1.6:8000/api/";
  static String baseUrl = "http://192.168.43.253:8000/api/";
  static String signIn = "login";
  static String signUp = "register";
  static String logout = "logout";
  static String categories = "categories";
  static String forgotPassword = "forgot-password";
  static String resetPassword = "reset-password";

  static String getUserDataEndPoint(id) {
    return "users/$id";
  }

  static String updateUserDataEndPoint(id) {
    return "users/update/$id";
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
