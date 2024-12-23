import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.43.253:8000/api', // رابط الـ API الأساسي
      // baseUrl: 'http://192.168.1.6:8000/api', // رابط الـ API الأساس
      // connectTimeout: const Duration(seconds: 10),
      // receiveTimeout: const Duration(seconds: 10),
    ),
  );
  Future<Map<String, dynamic>> login(String identifier, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'identifier': identifier.trim(),
          'password': password.trim(),
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            "Login failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
