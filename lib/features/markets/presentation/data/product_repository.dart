import 'package:delivery_app_new/core/api/api_conSumer.dart';

class ProductRepository {
  final ApiConsumer apiConsumer;

  ProductRepository({required this.apiConsumer});

  Future<Map<String, dynamic>> fetchProductData(int productId) async {
    try {
      final response = await apiConsumer
          // .get("http://192.168.43.59:8000/api/products/$productId");
          .get("http://192.168.43.253:8000/api/product/toprate?limit=10");
      return response['product'] as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch product data: $e');
    }
  }
}
