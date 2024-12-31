import 'package:delivery_app_new/core/api/end_points.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:delivery_app_new/features/markets/presentation/view/single_market_view.dart';
import 'package:delivery_app_new/features/markets/presentation/widget/custom_icon_botton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class cardMarketHome extends StatefulWidget {
  const cardMarketHome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _cardMarketHomeState createState() => _cardMarketHomeState();
}

// ignore: camel_case_types
class _cardMarketHomeState extends State<cardMarketHome> {
  List<Map<String, dynamic>> stores = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStores();
  }

  Future<void> fetchStores() async {
    try {
      final dio = Dio();
      final response = await dio
          .get("${EndPoint.baseUrl}${EndPoint.getTopRatedMarkets(limit: 5)}");

      if (response.statusCode == 200) {
        setState(() {
          stores = List<Map<String, dynamic>>.from(response.data['market']);
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (stores.isEmpty) {
      return const Center(child: Text("No markets available."));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: stores.length,
        itemBuilder: (context, index) {
          final store = stores[index];
          return Card(
            color: AppColors.afwait,
            elevation: 1,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      store['img'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 100),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          store['title'],
                          style: CustomTextStyle.parkinsans400Style12.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          store['location'],
                          style: CustomTextStyle.parkinsans400Style12.copyWith(
                            color: AppColors.goldenOrange,
                            fontSize: 11,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${store['rating']} (${store['rating_count']})',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 55),
                              child: CustomIconBotton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SingleMarketView(
                                        marketId: store['id'],
                                      ),
                                    ),
                                  );
                                },
                                text: '  more  ',
                                backgroundColor: AppColors.goldenOrange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
