import 'package:dio/dio.dart';

class NetworkInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('onRequest > ${options.path}');
    // print('onRequest > ${options.data}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('onResponse > ${response.statusCode}');
    // print('onResponse > ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('onError > ${err.message}');
    super.onError(err, handler);
  }
  
}
