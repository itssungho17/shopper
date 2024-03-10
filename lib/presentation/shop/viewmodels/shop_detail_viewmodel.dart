import 'package:flutter/widgets.dart';
import 'package:shopper/data/models/shop/product.dart';
import 'package:shopper/domain/shop/services/shop_service.dart';

class ShopDetailViewModel {
  
  final _service = ShopService();

  final isLoading = ValueNotifier<bool>(false);
  final product = ValueNotifier<Product?>(null);
  final error = ValueNotifier<String>('');

  void getProductById(int id) {
    isLoading.value = true;

    _service.getProductById(id)
      .then((value) {
        product.value = value;
      })
      .catchError((e) {
        error.value = e.toString();
      })
      .whenComplete((){
        isLoading.value = false;
      });
  }
}
