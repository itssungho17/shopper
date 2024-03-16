import 'package:flutter/material.dart';
import 'package:shopper/data/models/shop/product.dart';
import 'package:shopper/domain/services/shop/shop_service.dart';

class ShopViewModel with ChangeNotifier {

  final _service = ShopService();

  bool isLoading = false;
  List<Product> products = List<Product>.empty(growable: true);
  String error = '';

  void getProducts() {
    isLoading = true;
    notifyListeners();

    _service.getProducts()
      .then((value) {
        products = value;
      })
      .catchError((e) {
        error = e.toString();
      })
      .whenComplete((){
        isLoading = false;
        notifyListeners();
      });
  }
}
