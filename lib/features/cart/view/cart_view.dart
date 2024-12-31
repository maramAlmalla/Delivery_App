import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:delivery_app_new/core/widget/custom_text_field.dart';
import 'package:delivery_app_new/features/cart/models/card_product_cart.dart';
import 'package:delivery_app_new/features/cart/view_model/cart__item_model.dart';
import 'package:delivery_app_new/features/cart/view_model/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late Future<List<CartItem>> cartFuture;
  TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cartFuture = CartService().getCartItems();
  }

  void updateQuantity(int cartItemId, int newQuantity) async {
    try {
      await CartService().updateCartItemQuantity(cartItemId, newQuantity);
      setState(() {
        cartFuture = CartService().getCartItems();
      });
    } catch (e) {
      debugPrint('Error updating cart item: $e');
    }
  }

  void _showOrderDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.afwait,
        title: Text(
          'Order Location',
          style: CustomTextStyle.parkinsans400Style22.copyWith(
            color: AppColors.goldenOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: CustomTextField(
          hintText: 'Enter your location',
          icon: const Icon(Icons.location_on, color: Colors.grey),
          color: AppColors.afwait,
          textColor: Colors.black,
          controller: _locationController,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: CustomTextStyle.parkinsans400Style16
                  .copyWith(color: AppColors.black),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();

              try {
                final prefs = await SharedPreferences.getInstance();
                final cartId = prefs.getInt('cartId');
                final customerId = prefs.getInt('userId');
                final orderLocation = _locationController.text;

                if (cartId != null &&
                    customerId != null &&
                    orderLocation.isNotEmpty) {
                  await CartService()
                      .placeOrder(cartId, orderLocation, customerId);
                  debugPrint('Order placed successfully!');
                } else {
                  debugPrint('Error: Missing required data');
                }
              } catch (e) {
                debugPrint('Error placing order: $e');
              }
            },
            child: Text(
              'Confirm',
              style: CustomTextStyle.parkinsans400Style16
                  .copyWith(color: AppColors.goldenOrange),
            ),
          ),
        ],
      ),
    );
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
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkTealBlue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        CustomNavigationReplacement(context, '/Main');
                      },
                    ),
                  ),
                  Text(
                    'Cart',
                    style: CustomTextStyle.parkinsans500Style24.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkTealBlue,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkTealBlue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border,
                          color: Colors.white),
                      onPressed: () {
                        CustomNavigationReplacement(context, '/FavoriteView');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: FutureBuilder<List<CartItem>>(
              future: cartFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No items in the cart.'));
                }

                final cartItems = snapshot.data!;
                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return CardProductCard(
                      product: cartItem.product,
                      quantity: cartItem.quantity,
                      cartItemId: cartItem.id,
                      onDelete: () async {
                        try {
                          await CartService().deleteCartItem(cartItem.id);
                          setState(() {
                            cartFuture = CartService().getCartItems();
                          });
                          debugPrint('Cart item deleted successfully');
                        } catch (e) {
                          debugPrint('Error deleting cart item: $e');
                        }
                      },
                      onEdit: (newQuantity) {
                        updateQuantity(cartItem.id, newQuantity);
                      },
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.goldenOrange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Confirm Delete',
                            style: CustomTextStyle.parkinsans400Style22
                                .copyWith(
                                    color: AppColors.goldenOrange,
                                    fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                            'Are you sure you want to clear the cart? This action cannot be undone.',
                            style: CustomTextStyle.parkinsans300Style16
                                .copyWith(color: AppColors.black),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: CustomTextStyle.parkinsans400Style16
                                    .copyWith(color: AppColors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                try {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  final cartId = prefs.getInt('cartId');
                                  if (cartId != null) {
                                    await CartService().deleteCart(cartId);
                                    prefs.remove('cartId');
                                    setState(() {
                                      cartFuture = Future.value([]);
                                    });
                                    debugPrint('Cart cleared successfully!');
                                  } else {
                                    debugPrint('No cart ID found to clear');
                                  }
                                } catch (e) {
                                  debugPrint('Error clearing cart: $e');
                                }
                              },
                              child: Text(
                                'Delete',
                                style: CustomTextStyle.parkinsans400Style16
                                    .copyWith(color: AppColors.goldenOrange),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'Clear Cart',
                      style: CustomTextStyle.parkinsans300Style16.copyWith(
                        color: AppColors.afwait,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.goldenOrange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _showOrderDialog,
                    child: Text(
                      'Order',
                      style: CustomTextStyle.parkinsans300Style16.copyWith(
                        color: AppColors.afwait,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
