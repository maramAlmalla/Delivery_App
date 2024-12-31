import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:delivery_app_new/features/markets/presentation/view/single_product_view.dart';
import 'package:delivery_app_new/features/markets/presentation/widget/custom_icon_botton.dart';
import 'package:flutter/material.dart';

class PrudoctCardHome extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String size;
  final String totalQuantity;
  final double discount;
  final double rate;
  final int ratingCount;
  final int id;

  const PrudoctCardHome({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.size,
    required this.totalQuantity,
    required this.discount,
    required this.rate,
    required this.ratingCount,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 177, 170, 170),
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              width: 190,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.darkTealBlue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.image_not_supported,
                color: AppColors.afwait,
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CustomTextStyle.parkinsans400Style12.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: CustomTextStyle.parkinsans400Style12.copyWith(
                      color: const Color.fromARGB(255, 222, 220, 220),
                      fontSize: 11,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Discount: $discount%',
                    style: CustomTextStyle.parkinsans400Style12.copyWith(
                      color: AppColors.goldenOrange,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      Text(
                        '$rate ($ratingCount)',
                        style: CustomTextStyle.parkinsans300Style16.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: CustomIconBotton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleProductView(
                                  productId: id,
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
  }
}
