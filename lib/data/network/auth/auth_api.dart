import 'package:dio/dio.dart';
import 'package:shopper/data/models/auth/user.dart';
import 'package:shopper/data/network/auth/dto/req_auth.dart';
import 'package:shopper/data/network/common/network_manager.dart';

class AuthApi {

  final _dio = NetworkManager().dio;
  
  Future<User> login(String username, String password) async {
    try {
      final reqAuth = ReqAuth(username: username, password: password, expiresInMins: 60);
      var response = await _dio.post('/auth/login', data: reqAuth.toJson());
      return User.fromJson(response.data);
    } on DioException catch (e) {
      return Future.error(e.message ?? '');
    }
  }
}
