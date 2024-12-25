import 'package:delivery_app_new/core/api/api_conSumer.dart';
import 'package:delivery_app_new/core/api/end_points.dart';

class ProductRepository {
  final ApiConsumer apiConsumer;

  ProductRepository({required this.apiConsumer});

  Future<Map<String, dynamic>> fetchProductData(int productId) async {
    try {
      final response = await apiConsumer.get(
          "${EndPoint.baseUrl}${EndPoint.getTopRatedProductsUrl(limit: 10)}");

      if (!response.containsKey('products')) {
        throw Exception('Response does not contain "products" key.');
      }

      final products = response['products'] as List<dynamic>;
      final product = products.firstWhere(
        (product) => product['id'] == productId,
        orElse: () => null,
      );

      if (product == null) {
        throw Exception('Product with ID $productId not found.');
      }

      return product as Map<String, dynamic>;
    } catch (e) {
      print("Error in fetchProductData: $e");
      throw Exception('Failed to fetch product data: $e');
    }
  }
}
