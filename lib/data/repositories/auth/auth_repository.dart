import 'package:shopper/data/models/auth/user.dart';
import 'package:shopper/data/network/auth/auth_api.dart';

class AuthRepository {
  final AuthApi _source = AuthApi();

  Future<User> login(String username, String password) async {
    return await _source.login(username, password);
  }
}
