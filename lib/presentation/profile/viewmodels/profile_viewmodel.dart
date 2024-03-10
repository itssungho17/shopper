import 'package:flutter/material.dart';
import 'package:shopper/data/models/auth/user.dart';
import 'package:shopper/domain/services/auth/auth_service.dart';

class ProfileViewModel {

  final _service = AuthService();

  final isLoading = ValueNotifier<bool>(false);
  final user = ValueNotifier<User?>(null);
  final error = ValueNotifier<String>('');

  void login() {
    isLoading.value = true;

    _service.login('kminchelle', '0lelplR')
      .then((value) {
        print(value);
      })
      .catchError((e) {
        error.value = e.toString();
      })
      .whenComplete((){
        isLoading.value = false;
      });
  }
}
