import 'package:delivery_app_new/core/api/end_points.dart';
import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:delivery_app_new/features/markets/presentation/view/single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  List favorites = [];
  bool isLoading = true;
  int? userId;

  @override
  void initState() {
    super.initState();
    fetchUserId();
  }

  Future<void> fetchUserId() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getInt('userId');

      if (userId != null) {
        fetchFavorites(userId!);
      } else {
        setState(() {
          isLoading = false;
        });
        print('User ID not found in local storage.');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching user ID: $e');
    }
  }

  Future<void> fetchFavorites(int userId) async {
    try {
      final response = await Dio().get(
        '${EndPoint.baseUrl}users/$userId/favorites',
      );
      setState(() {
        favorites = response.data['data'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching favorites: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.afwait,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.afwait),
                    onPressed: () {
                      CustomNavigationReplacement(context, '/Main'); // Go back
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.darkTealBlue,
                    ),
                  ),
                  Text(
                    'Favorite',
                    style: CustomTextStyle.parkinsans500Style24.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkTealBlue,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : favorites.isEmpty
                    ? const Center(
                        child: Text(
                          'No favorites found!',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          final item = favorites[index];
                          final product = item['product'];

                          return Card(
                            color: const Color.fromARGB(255, 167, 162, 162),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: AppColors.darkTealBlue,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: const Icon(
                                          Icons.image,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product['title'],
                                              style: CustomTextStyle
                                                  .parkinsans400Style12
                                                  .copyWith(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              product['description'],
                                              style: CustomTextStyle
                                                  .parkinsans400Style12
                                                  .copyWith(
                                                color: const Color.fromARGB(
                                                    255, 222, 220, 220),
                                                fontSize: 12,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Price: \$${product['price']}',
                                              style: CustomTextStyle
                                                  .parkinsans400Style12
                                                  .copyWith(
                                                color: AppColors.goldenOrange,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            // Add Rating and Rating Count with button in the same row
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow[600],
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${product['rate']}',
                                                  style: CustomTextStyle
                                                      .parkinsans400Style12
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  '(${product['rating_count']})',
                                                  style: CustomTextStyle
                                                      .parkinsans400Style12
                                                      .copyWith(
                                                    color: const Color.fromARGB(
                                                        255, 222, 220, 220),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const Spacer(),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    final productId =
                                                        product['id'];
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            SingleProductView(
                                                          productId: productId,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.darkTealBlue,
                                                  ),
                                                  child: Text(
                                                    'More',
                                                    style: CustomTextStyle
                                                        .parkinsans400StyleW14
                                                        .copyWith(
                                                            color: AppColors
                                                                .afwait),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
