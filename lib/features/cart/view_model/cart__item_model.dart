import 'package:delivery_app_new/features/cart/view_model/product_factory_cart.dart';

class CartItem {
  final int id;
  final Product product;
  final int quantity;

  CartItem({required this.id, required this.product, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? 0,
      product: Product.fromJson(json['product'] ?? {}),
      quantity: (json['quantity'] is String)
          ? int.tryParse(json['quantity']) ?? 0
          : json['quantity'] ?? 0,
    );
  }
}
