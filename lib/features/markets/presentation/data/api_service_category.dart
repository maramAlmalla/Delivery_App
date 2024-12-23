import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<List<String>> getCategories(String url) async {
    try {
      final response = await _dio.get(url);
      final data = response.data['data'] as List;
      return data.map((item) => item['name'] as String).toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }
}
