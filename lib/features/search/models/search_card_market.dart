import 'package:flutter/material.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:delivery_app_new/features/markets/presentation/view/single_market_view.dart';
import 'package:delivery_app_new/features/markets/presentation/widget/custom_icon_botton.dart';

class SearchCardMarket extends StatelessWidget {
  final Map<String, dynamic> market;

  const SearchCardMarket({super.key, required this.market});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.afwait,
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                market['img'],
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
                    market['title'] ?? 'No title',
                    style: CustomTextStyle.parkinsans400StyleW14.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    market['location'] ?? 'No location',
                    style: CustomTextStyle.parkinsans300Style16.copyWith(
                      color: AppColors.goldenOrange,
                      fontSize: 11,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${market['rating']} (${market['rating_count']})',
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
                                  marketId: market['id'],
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
