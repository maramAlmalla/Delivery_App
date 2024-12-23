import 'package:delivery_app_new/core/api/api_conSumer.dart';
import 'package:delivery_app_new/core/api/end_points.dart';

class MarketRepository {
  final ApiConsumer apiConsumer;

  MarketRepository({required this.apiConsumer});

  Future<Map<String, dynamic>> fetchMarketData(int marketId) async {
    try {
      final response =
          await apiConsumer.get("${EndPoint.baseUrl}markets/$marketId");
      return response;
    } catch (e) {
      throw Exception('Failed to fetch market data: $e');
    }
  }
}
