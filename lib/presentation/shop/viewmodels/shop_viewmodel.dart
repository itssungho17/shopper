import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopper/data/models/shop/product.dart';
import 'package:shopper/domain/providers/auth_provider.dart';
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

final shopVM = ChangeNotifierProvider.autoDispose<ShopViewModel>((ref) {
  final vm = ShopViewModel();
  vm.getProducts();

  ref.listen(authProvider, (previous, next) {
    vm.getProducts();
  });
  
  return vm;
});
