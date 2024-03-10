import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/data/models/auth/user.dart';
import 'package:shopper/data/preferences/preferences_key.dart';
import 'package:shopper/data/repositories/auth/auth_repository.dart';
import 'package:shopper/domain/providers/auth_provider.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  AuthService._internal();

  final _repository = AuthRepository();
  final _auth = AuthProvider();

  Future<User> login(String username, String password) async {
    final user = await _repository.login(username, password);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKey.username, username);
    prefs.setString(PreferencesKey.password, password);

    _auth.login(user);

    return user;
  }

  void logout() {
    _auth.logout();
  }
}
