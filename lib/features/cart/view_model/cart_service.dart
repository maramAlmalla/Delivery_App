import 'package:delivery_app_new/core/api/end_points.dart';
import 'package:delivery_app_new/core/database/cache/cache_helper.dart';
import 'package:delivery_app_new/features/cart/view_model/cart__item_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  final Dio dio = Dio();

  Future<List<CartItem>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartId = prefs.getInt('cartId') ?? 0;
    print('Cart ID: $cartId');

    if (cartId == 0) {
      print('Error: Cart ID not found');
      throw Exception('Cart ID not found');
    }

    try {
      final url = '${EndPoint.baseUrl}carts/$cartId';
      print('API URL: $url');
      final response = await dio.get(
        url,
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        print('Response data: ${response.data}');
        final List items = response.data['cart_items'] ?? [];
        return items.map((item) => CartItem.fromJson(item)).toList();
      } else if (response.statusCode == 404) {
        print('Error: Cart not found.');
        throw Exception('Cart not found');
      } else {
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      print('Error: Failed to fetch cart - $e');
      throw Exception('Failed to fetch cart: $e');
    }
  }

  Future<void> deleteCartItem(int cartItemId) async {
    try {
      final url = '${EndPoint.baseUrl}cart-items/$cartItemId';
      final response = await dio.delete(
        url,
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        print('Success: ${response.data}');
      } else {
        print('Failed: ${response.statusCode} - ${response.data}');
        throw Exception('Failed to delete cart item');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> updateCartItemQuantity(int cartItemId, int quantity) async {
    if (quantity <= 0) {
      throw Exception('Quantity must be greater than zero');
    }

    try {
      final url = '${EndPoint.baseUrl}cart-items/$cartItemId';
      final response = await dio.put(
        url,
        data: {"quantity": quantity},
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        print('Success: ${response.data}');
      } else {
        print('Failed: ${response.statusCode} - ${response.data}');
        throw Exception('Failed to update cart item');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> deleteCart(int cartId) async {
    try {
      final url = '${EndPoint.baseUrl}carts/$cartId';
      final response = await dio.delete(
        url,
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        print('Cart deleted successfully');
      } else {
        print(
            'Failed to delete cart: ${response.statusCode} - ${response.data}');
        throw Exception('Failed to delete cart');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> placeOrder(
      int cartId, String orderLocation, int customerId) async {
    try {
      final response = await dio.post(
        '${EndPoint.baseUrl}orders',
        data: FormData.fromMap({
          'cartId': cartId,
          'orderLocation': orderLocation,
          'customerId': customerId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Order placed successfully: ${response.data}');

        try {
          final newCartId = await createCart(customerId);

          await CacheHelper.sharedPreferences.setInt('cartId', newCartId);
          print('Cart ID updated and saved: $newCartId');
        } catch (e) {
          print('An error occurred while creating the new cart: $e');
        }
      } else {
        print('Order failed: ${response.statusCode} - ${response.data}');
        throw Exception('Failed to place order');
      }
    } catch (e) {
      print('An error occurred while placing the order: $e');
      throw Exception('Order placement failed');
    }
  }

  Future<int> createCart(int userId) async {
    try {
      final response = await dio.post(
        '${EndPoint.baseUrl}carts',
        data: {'userId': userId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Cart created successfully: ${response.data}');
        final newCartId = response.data['cart']['id'];
        return newCartId;
      } else {
        print(
            'Failed to create cart: ${response.statusCode} - ${response.data}');
        throw Exception('Failed to create cart');
      }
    } catch (e) {
      print('Error while creating the cart: $e');
      throw Exception('Error creating cart for userId: $userId');
    }
  }
}
