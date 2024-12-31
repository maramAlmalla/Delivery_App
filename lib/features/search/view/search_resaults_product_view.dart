import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:delivery_app_new/features/markets/presentation/view/single_product_view.dart';
import 'package:flutter/material.dart';

class SearchResultsProductPage extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults;

  const SearchResultsProductPage({super.key, required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.afwait),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Search Results",
          style: CustomTextStyle.parkinsans500Style24.copyWith(
            color: AppColors.tealGreen,
            fontSize: 25,
          ),
        ),
        backgroundColor: AppColors.darkTealBlue,
      ),
      body: searchResults.isEmpty
          ? const Center(
              child: Text(
                "No products found.",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final product = searchResults[index];

                return Card(
                  color: const Color.fromARGB(255, 167, 162, 162),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: product['images'] != null &&
                                      product['images'] is List &&
                                      product['images'].isNotEmpty
                                  ? Image.network(product['images'][0])
                                  : const Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['title'] ?? 'No Title',
                                    style: CustomTextStyle.parkinsans400Style12
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
                                    product['description'] ?? 'No Description',
                                    style: CustomTextStyle.parkinsans400Style12
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
                                    'Price: \$${product['price']?.toString() ?? 'N/A'}',
                                    style: CustomTextStyle.parkinsans400Style12
                                        .copyWith(
                                      color: AppColors.goldenOrange,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow[600],
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${product['rate'] ?? 0}',
                                        style: CustomTextStyle
                                            .parkinsans400Style12
                                            .copyWith(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(), // Spacer to push the button to the right
                                      ElevatedButton(
                                        onPressed: () {
                                          final productId = product['id'];
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
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.darkTealBlue,
                                        ),
                                        child: Text(
                                          'More',
                                          style: CustomTextStyle
                                              .parkinsans400StyleW14
                                              .copyWith(
                                                  color: AppColors.afwait),
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
    );
  }
}
