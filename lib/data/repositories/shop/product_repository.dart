import 'package:shopper/data/common/data_source.dart';
import 'package:shopper/data/models/shop/product.dart';

class ProductRepository {
  final DataSource source;

  ProductRepository({ required this.source });

  List<Product> _products = List.empty(growable: true);
  Product? _product;

  Future<Product> addOne(Product item) async {
    return await source.addOne(item);
  }
  
  Future<Product> deleteOne(Product item) async {
    return await source.deleteOne(item);
  }
  
  Future<List<Product>> getAll() async {
    _products = await source.getAll() as List<Product>;
    return _products;
  }

  List<Product> getAllFromCache()  {
    return _products;
  }
  
  Future<Product> getOne(int id) async {
    _product = await source.getOne(id.toString());
    return _product!;
  }
  
  Product? getLastOneFromCache()  {
    return _product;
  }
  
  Future<Product> updateOne(Product item) async {
    return await source.updateOne(item);
  }
  
}
