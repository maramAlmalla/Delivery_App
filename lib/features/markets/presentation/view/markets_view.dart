import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:delivery_app_new/features/markets/presentation/widget/categories_scroll_widget.dart';
import 'package:delivery_app_new/features/markets/presentation/widget/custom_icon_botton.dart';
import 'package:delivery_app_new/features/markets/presentation/widget/market_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MarketsView extends StatefulWidget {
  const MarketsView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MarketsViewState createState() => _MarketsViewState();
}

class _MarketsViewState extends State<MarketsView> {
  List<Map<String, dynamic>> markets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMarkets();
  }

  @override
  Future<void> fetchMarkets() async {
    try {
      print('Fetching markets...');
      final dio = Dio();
      // final response = await dio.get('http://192.168.43.59:8000/api/markets');
      final response = await dio.get('http://192.168.43.253:8000/api/markets');
      print('Response received: ${response.data}');
      print(response.statusCode);

      final data = response.data['data'] as List;

      setState(() {
        markets = data.map((item) {
          return {
            'id': item['id'] ?? 0,
            'title': item['title'] ?? 'No Title',
            'location': item['location'] ?? 'No Location',
            'img': item['img'] ??
                '', // إذا كانت الصورة فارغة، نعالجها في MarketCard
            'rating': (item['rating'] as num?)?.toDouble() ?? 0.0,
          };
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching markets: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 170,
            decoration: BoxDecoration(
              color: AppColors.darkTealBlue,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          Positioned(
            left: 2,
            top: 50,
            child: CustomIconBotton(
              onPressed: () {
                Navigator.pop(context);
              },
              icons: const Icon(Icons.arrow_back, size: 24),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: Row(
              children: [
                CustomIconBotton(
                  onPressed: () {
                    CustomNavigationReplacement(context, "/SearchView");
                  },
                  icons: const Icon(Icons.search),
                ),
                CustomIconBotton(
                  onPressed: () {
                    CustomNavigationReplacement(context, "/CartView");
                  },
                  icons: const Icon(Icons.add_shopping_cart),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 130,
            child: Text(
              'Markets',
              style: CustomTextStyle.parkinsans400Style16.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.tealGreen,
              ),
            ),
          ),
          Positioned(
            top: 185,
            left: 20,
            bottom: 20,
            child: Text(
              'Departments : ',
              style:
                  CustomTextStyle.parkinsans600Style28.copyWith(fontSize: 20),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    height: MediaQuery.of(context).size.height - 300,
                    child: ListView.builder(
                      itemCount: markets.length,
                      itemBuilder: (context, index) {
                        final market = markets[index];
                        return MarketCard(
                          title: market['title'],
                          location: market['location'],
                          imageUrl: market['img'],
                          rating: market['rating'],
                          id: market['id'],
                        );
                      },
                    ),
                  ),
          ),
          const Align(
              alignment: Alignment.centerRight,
              child: CategoriesScrollWidget()),
        ],
      ),
    );
  }
}
