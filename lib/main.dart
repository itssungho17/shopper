import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/data/preferences/preferences_key.dart';
import 'package:shopper/domain/services/auth/auth_service.dart';
import 'package:shopper/presentation/main/views/main_view.dart';
import 'package:shopper/domain/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
      ],
      child: const ShopperApp(),
    )
  );
}

class ShopperApp extends StatefulWidget {
  const ShopperApp({super.key});

  @override
  State<ShopperApp> createState() => _ShopperAppState();
}

class _ShopperAppState extends State<ShopperApp> {

  @override
  void initState() {
    super.initState();
    fetchDeviceInfo();
    fetchAuthInfo();
  }

  void fetchDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      print(androidInfo.version.release);
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      print(iosInfo.systemVersion);
    }
  }

  void fetchAuthInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(PreferencesKey.username);
    final password = prefs.getString(PreferencesKey.password);
    
    if (username != null && password != null) {
      AuthService().login(username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainView(),
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineMedium:  TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
          labelMedium: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.cyanAccent,
          ),
          labelSmall: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        )
      ),
    );
  }
}
