import 'package:dio/dio.dart';
import 'package:shopper/data/network/common/network_interceptor.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();
  factory NetworkManager() => _instance;

  late Dio dio;

  NetworkManager._internal() {
    dio = Dio();
    configureDio();
    addInterceptor(NetworkInterceptor());
  }

  void configureDio() {
    dio.options.baseUrl = 'https://dummyjson.com';
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

}
