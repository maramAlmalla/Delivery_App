class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discount;
  final String size;
  final int totalQuantity;
  final double rate;
  final int ratingCount;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discount,
    required this.size,
    required this.totalQuantity,
    required this.rate,
    required this.ratingCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      price: (json['price'] is String)
          ? double.tryParse(json['price']) ?? 0.0
          : (json['price'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] is String)
          ? double.tryParse(json['discount']) ?? 0.0
          : (json['discount'] as num?)?.toDouble() ?? 0.0,
      size: json['size'] ?? 'N/A',
      totalQuantity: json['totalQuantity'] ?? 0,
      rate: (json['rate'] is String)
          ? double.tryParse(json['rate']) ?? 0.0
          : (json['rate'] as num?)?.toDouble() ?? 0.0,
      ratingCount: json['rating_count'] ?? 0,
    );
  }
}
