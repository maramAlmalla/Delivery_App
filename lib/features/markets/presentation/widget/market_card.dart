import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:delivery_app_new/features/markets/presentation/view/single_market_view.dart';
import 'package:delivery_app_new/features/markets/presentation/widget/custom_icon_botton.dart';
import 'package:flutter/material.dart';

class MarketCard extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final double rating;
  final int id;

  const MarketCard({
    super.key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkTealBlue,
      margin: const EdgeInsets.only(left: 20, top: 20, right: 120),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.darkTealBlue,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl)
                      : const AssetImage('assets/image/placeholder.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        title,
                        style: CustomTextStyle.parkinsans400Style12.copyWith(
                          color: AppColors.afwait,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    location,
                    style: CustomTextStyle.parkinsans400Style12.copyWith(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 7),
                        child: Icon(Icons.star, color: Colors.amber, size: 18),
                      ),
                      Text(
                        '$rating',
                        style: CustomTextStyle.parkinsans300Style16
                            .copyWith(color: Colors.white, fontSize: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: CustomIconBotton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SingleMarketView(marketId: id),
                              ),
                            );
                          },
                          text: 'more',
                          backgroundColor: AppColors.goldenOrange,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
