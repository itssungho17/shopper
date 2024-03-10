import 'package:shopper/data/models/shop/product.dart';

class ResProducts {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  ResProducts({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ResProducts.fromJson(Map<String, dynamic> json) {
    final products = (json['products'] as List)
        .map((product) => Product.fromJson(product))
        .toList();
    return ResProducts(
      products: products,
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
