import 'package:delivery_app_new/core/api/dio_consumer.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:delivery_app_new/features/markets/presentation/data/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SingleProductView extends StatefulWidget {
  final int productId;

  const SingleProductView({super.key, required this.productId});

  @override
  // ignore: library_private_types_in_public_api
  _SingleProductViewState createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  Map<String, dynamic>? productData;
  bool isLoading = true;
  late ProductRepository productRepository;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    productRepository = ProductRepository(apiConsumer: DioConsumer(dio: Dio()));
    fetchProductData(widget.productId);
  }

  Future<void> fetchProductData(int productId) async {
    try {
      final data = await productRepository.fetchProductData(productId);
      print(data);
      setState(() {
        productData = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching product data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : productData == null
              ? const Center(child: Text('Failed to load product data'))
              : Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(context),
                          const SizedBox(height: 32),
                          _buildProductImages(),
                          const SizedBox(height: 10),
                          _buildProductTitleAndPrice(),
                          const SizedBox(height: 14),
                          _buildRating(),
                          const SizedBox(height: 10),
                          _buildAdditionalDetails(),
                          const SizedBox(height: 20),
                          _buildDescription(),
                        ],
                      ),
                    ),
                    _buildBottomBar(),
                  ],
                ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.darkTealBlue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            'Product Details',
            style: CustomTextStyle.parkinsans300Style16.copyWith(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProductImages() {
    final images = productData?['images'] as List<dynamic>? ?? [];
    return images.isNotEmpty
        ? SizedBox(
            height: 200,
            // width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.network(
                      images[index]['url'],
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          )
        : const SizedBox();
  }

  Widget _buildProductTitleAndPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productData?['title'] ?? 'Default Product',
            style: CustomTextStyle.parkinsans300Style16.copyWith(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${productData?['price'] ?? '0.00'}',
            style: CustomTextStyle.parkinsans300Style16.copyWith(
              fontSize: 24,
              color: AppColors.goldenOrange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 32),
          const SizedBox(width: 8),
          Text(
            '${productData?['rate'] ?? '0.0'}',
            style: CustomTextStyle.parkinsans300Style16.copyWith(
                fontSize: 16,
                color: AppColors.tealGreen,
                fontWeight: FontWeight.bold),
          ),
          Text(
            ' (${productData?['rating_count'] ?? '0'} ratings)',
            style: CustomTextStyle.parkinsans300Style16.copyWith(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discount: ${productData?['discount'] ?? 'N/A'}%',
            style: CustomTextStyle.parkinsans300Style16.copyWith(
              fontSize: 16,
              color: AppColors.goldenOrange,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Size: ${productData?['size'] ?? 'N/A'}',
            style: CustomTextStyle.parkinsans300Style16.copyWith(
              fontSize: 16,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Available Quantity: ${productData?['totalQuantity'] ?? '0'}',
            style: CustomTextStyle.parkinsans300Style16.copyWith(
              fontSize: 16,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Created At: ${productData?['created_at'] ?? 'N/A'}',
            style: CustomTextStyle.parkinsans300Style16.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Updated At: ${productData?['updated_at'] ?? 'N/A'}',
            style: CustomTextStyle.parkinsans300Style16.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        productData?['description'] ?? 'No description available',
        style: CustomTextStyle.parkinsans300Style16.copyWith(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildQuantitySelector(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.goldenOrange,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {},
              child: Text(
                'Add to cart',
                style: CustomTextStyle.parkinsans300Style16.copyWith(
                  fontSize: 16,
                  color: AppColors.afwait,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (quantity > 1) {
                    quantity--;
                  }
                });
              },
            ),
            Text('$quantity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.tealGreen,
                )),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  quantity++;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
