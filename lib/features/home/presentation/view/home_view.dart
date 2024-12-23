import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:delivery_app_new/features/home/presentation/widget/appbar_home_view.dart';
import 'package:delivery_app_new/features/home/presentation/widget/card_market_home.dart';
import 'package:delivery_app_new/features/home/presentation/widget/product_card_home.dart';
import 'package:delivery_app_new/features/markets/presentation/widget/categories_scroll_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final dio = Dio();
      final response = await dio
          // .get("http://192.168.43.59:8000/api/product/toprate?limit=10");
          .get("http://192.168.43.253:8000/api/product/toprate?limit=10");
      if (response.statusCode == 200) {
        print("API Response: ${response.data}");
        final data = response.data['products'] as List;
        return data.map((item) {
          return {
            "id": item["id"],
            "title": item["title"],
            "description": item["description"],
            "price": double.tryParse(item["price"].toString()) ?? 0.0,
            "discount": double.tryParse(item["discount"].toString()) ?? 0.0,
            "size": item["size"] ?? "N/A",
            "totalQuantity": item["totalQuantity"].toString(),
            "rate": (item["rate"] is int)
                ? (item["rate"] as int).toDouble()
                : double.tryParse(item["rate"].toString()) ?? 0.0,
            "ratingCount": item["rating_count"] ?? 0,
          };
        }).toList();
      } else {
        throw Exception("Failed to fetch products");
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.afwait,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppbarHomeView(),
            const CategoriesScrollWidget(
              scrollDirection: Axis.horizontal,
              showOuterContainer: false,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 100),
              child: Text(
                'Recommended for you:',
                style: CustomTextStyle.parkinsans400Style16
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
            SizedBox(
              height: 270,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No products available."));
                  }

                  final products = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return SizedBox(
                        width: 200,
                        child: PrudoctCardHome(
                          id: product["id"],
                          title: product["title"],
                          description: product["description"],
                          price: product["price"].toString(),
                          discount: product["discount"],
                          size: product["size"],
                          totalQuantity: product["totalQuantity"],
                          rate: product["rate"],
                          ratingCount: product["ratingCount"],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 240),
              child: Text(
                'Activity :',
                style: CustomTextStyle.parkinsans400Style16
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
            cardMarketHome(),
          ],
        ),
      ),
    );
  }
}
