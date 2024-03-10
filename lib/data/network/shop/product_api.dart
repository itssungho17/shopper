import 'package:dio/dio.dart';
import 'package:shopper/data/common/data_source.dart';
import 'package:shopper/data/models/shop/product.dart';
import 'package:shopper/data/network/common/network_manager.dart';
import 'package:shopper/data/network/shop/dto/res_products.dart';

class ProductApi implements DataSource<Product> {

  final _dio = NetworkManager().dio;
  
  @override
  Future<Product> addOne(Product item) async {
    try {
      var response = await _dio.post('/products/add', data: item.toJson());
      return Product.fromJson(response.data);
    } on DioException catch (e) {
      return Future.error(e.message ?? '');
    }
  }
  
  @override
  Future<Product> deleteOne(Product item) async {
    try {
      var response = await _dio.delete('/products/${item.id}');
      return Product.fromJson(response.data);
    } on DioException catch (e) {
      return Future.error(e.message ?? '');
    }
  }
  
  @override
  Future<List<Product>> getAll() async {
    try {
      var response = await _dio.get('/products');
      return ResProducts.fromJson(response.data).products;
    } on DioException catch (e) {
      return Future.error(e.message ?? '');
    }
  }
  
  @override
  Future<Product> getOne(String key) async {
    try {
      var response = await _dio.get('/products/$key');
      return Product.fromJson(response.data);
    } on DioException catch (e) {
      return Future.error(e.message ?? '');
    }
  }
  
  @override
  Future<Product> updateOne(Product item) async {
    try {
      var response = await _dio.put('/products/${item.id}', data: item.toJson());
      return Product.fromJson(response.data);
    } on DioException catch (e) {
      return Future.error(e.message ?? '');
    }
  }
  
}
