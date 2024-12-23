class SignUpModel {
  final String message;
  final String? token; // اجعل التوكن Nullable

  SignUpModel({required this.message, this.token});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      message: json['message'] ?? 'No message',
      token: json['user']?['token'], // تأكد من الوصول إلى التوكن داخل user
    );
  }
}
