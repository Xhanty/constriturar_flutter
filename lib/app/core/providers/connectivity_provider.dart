import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:constriturar/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:constriturar/app.dart'; // Asegúrate de importar el archivo en el que se define navigatorKey

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool _isConnected = true;
  StreamSubscription? _subscription;

  bool get isConnected => _isConnected;

  ConnectivityProvider() {
    _subscription = _connectivity.onConnectivityChanged.listen((result) async {
      _isConnected = await _hasInternet();
      notifyListeners();
      _handleNavigation();
    });

    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    _isConnected = await _hasInternet();
    notifyListeners();
    _handleNavigation();
  }

  Future<bool> _hasInternet() async {
    try {
      final response = await http
          .get(Uri.parse("https://www.google.com"))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  void _handleNavigation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Usamos navigatorKey para realizar la navegación sin depender del context
      if (!_isConnected) {
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.noConnection);
      } else {
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
