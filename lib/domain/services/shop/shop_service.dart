import 'package:shopper/data/database/shop/product_db.dart';
import 'package:shopper/data/models/shop/product.dart';
import 'package:shopper/data/network/shop/product_api.dart';
import 'package:shopper/data/repositories/shop/product_repository.dart';
import 'package:shopper/domain/providers/auth_provider.dart';

class ShopService {
  static final ShopService _instance = ShopService._internal();
  factory ShopService() => _instance;

  ShopService._internal() {
    if (AuthProvider().user == null) {
      _repository = ProductRepository(source: ProductDB());
    } else {
      _repository = ProductRepository(source: ProductApi());
    }
  }

  late ProductRepository _repository;

  ProductRepository get repository {
    if (AuthProvider().user == null) {
      if (_repository.source is ProductApi) {
        _repository = ProductRepository(source: ProductDB());
      }
    } else {
      if (_repository.source is ProductDB) {
        _repository = ProductRepository(source: ProductApi());
      }
    }
    return _repository;
  }

  Future<List<Product>> getProducts() async {
    return await repository.getAll();
  }

  Future<Product> getProductById(int id) async {
    return await repository.getOne(id);
  }
}
