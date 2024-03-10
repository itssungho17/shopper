import 'package:flutter/material.dart';
import 'package:shopper/data/models/shop/product.dart';
import 'package:shopper/domain/shop/services/shop_service.dart';

class ShopViewModel {

  final _service = ShopService();

  final isLoading = ValueNotifier<bool>(false);
  final products = ValueNotifier<List<Product>>([]);
  final error = ValueNotifier<String>('');

  void getProducts() {
    isLoading.value = true;

    _service.getProducts()
      .then((value) {
        products.value = value;
      })
      .catchError((e) {
        error.value = e.toString();
      })
      .whenComplete((){
        isLoading.value = false;
      });
  }
}
