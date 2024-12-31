import 'package:delivery_app_new/core/api/dio_consumer.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:delivery_app_new/features/markets/presentation/data/market_repository.dart';
import 'package:delivery_app_new/features/markets/presentation/view/single_product_view.dart';
import 'package:delivery_app_new/features/markets/presentation/widget/custom_icon_botton.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SingleMarketView extends StatefulWidget {
  final int marketId;
  const SingleMarketView({super.key, required this.marketId});

  @override
  _SingleMarketViewState createState() => _SingleMarketViewState();
}

class _SingleMarketViewState extends State<SingleMarketView> {
  Map<String, dynamic>? marketData;
  bool isLoading = true;
  late MarketRepository marketRepository;

  @override
  void initState() {
    super.initState();

    marketRepository = MarketRepository(
      apiConsumer: DioConsumer(dio: Dio()),
    );
    fetchMarketData(widget.marketId);
  }

  Future<void> fetchMarketData(int marketId) async {
    try {
      final data = await marketRepository.fetchMarketData(marketId);
      setState(() {
        marketData = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : marketData == null
                ? const Center(child: Text('Failed to load market data'))
                : SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.darkTealBlue,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              Text(
                                'Market',
                                style: CustomTextStyle.parkinsans400Style22
                                    .copyWith(
                                        color: AppColors.afwait,
                                        fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_shopping_cart,
                                    color: Colors.white),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          child: Image.network(
                            marketData?['img'] ?? '',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/image/kk.png',
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  marketData?['title'] ?? 'No title available',
                                  style: CustomTextStyle.parkinsans500Style24
                                      .copyWith(
                                          fontSize: 24,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  marketData?['location'] ??
                                      'No location available',
                                  style: CustomTextStyle.parkinsans300Style16
                                      .copyWith(
                                    fontSize: 16,
                                    color: AppColors.goldenOrange,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      marketData?['rating']?.toString() ??
                                          '0.0',
                                      style: CustomTextStyle
                                          .parkinsans500Style24
                                          .copyWith(
                                        fontSize: 15,
                                        color: AppColors.tealGreen,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "(${marketData?['rating_count'] ?? 0} reviews)",
                                      style: CustomTextStyle
                                          .parkinsans500Style24
                                          .copyWith(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Divider(
                                  color:
                                      const Color.fromARGB(255, 205, 203, 203),
                                  height: 1,
                                ),
                                Text(
                                  'Products',
                                  style: CustomTextStyle.parkinsans500Style24
                                      .copyWith(fontSize: 23),
                                ),
                                const SizedBox(height: 8),
                                ...List.generate(
                                    (marketData?['products']
                                                as List<dynamic>? ??
                                            [])
                                        .length, (index) {
                                  final product =
                                      marketData!['products'][index];
                                  return Card(
                                      color: AppColors.deepTeal,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      elevation: 20,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.network(
                                                    product['img'] ?? '',
                                                    width: 80,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        'assets/image/kk.png',
                                                        width: 80,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        product['title'] ??
                                                            'No title',
                                                        style: CustomTextStyle
                                                            .parkinsans500Style24
                                                            .copyWith(
                                                                fontSize: 20,
                                                                color: AppColors
                                                                    .afwait),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Price :  ',
                                                            style: CustomTextStyle
                                                                .parkinsans300Style16
                                                                .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    color: AppColors
                                                                        .afwait),
                                                          ),
                                                          Text(
                                                            '\$${product['price'] ?? '0.0'}',
                                                            style: CustomTextStyle
                                                                .parkinsans300Style16
                                                                .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    color: AppColors
                                                                        .goldenOrange),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Discount:   ',
                                                            style: CustomTextStyle
                                                                .parkinsans300Style16
                                                                .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    color: AppColors
                                                                        .afwait),
                                                          ),
                                                          Text(
                                                            '\$${product['discount'] ?? 0.0}',
                                                            style: CustomTextStyle
                                                                .parkinsans300Style16
                                                                .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    color: AppColors
                                                                        .goldenOrange),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(children: [
                                                        const Icon(Icons.star,
                                                            color: Colors.amber,
                                                            size: 20),
                                                        Text(
                                                          "${product['rate'] ?? 0.0} ",
                                                          style: CustomTextStyle
                                                              .parkinsans300Style16
                                                              .copyWith(
                                                            fontSize: 15,
                                                            color: AppColors
                                                                .tealGreen,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 55),
                                                          child:
                                                              CustomIconBotton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SingleProductView(
                                                                    productId:
                                                                        product[
                                                                            'id'],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            text: '  more  ',
                                                            backgroundColor:
                                                                AppColors
                                                                    .goldenOrange,
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                ),
                                              ])));
                                })
                              ],
                            )),
                      ])));
  }
}
