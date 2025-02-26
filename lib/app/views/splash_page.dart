import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:constriturar/app/core/services/secure_storage_service.dart';
import 'package:constriturar/app/routes/routes.dart';
import 'package:constriturar/app/views/modules/home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SecureStorageService _secureStorageService = SecureStorageService();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      _checkTokens();
    });
  }

  void _checkTokens() async {
    final accessToken = await _secureStorageService.getAccessToken();
    final refreshToken = await _secureStorageService.getRefreshToken();

    if (accessToken != null && refreshToken != null) {
      if (!mounted) return;
      AppRoutes.setView(const HomePage(), context);
    } else {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Center(
      child: Lottie.asset(
        'assets/animations/splash.json',
      ),
    );
  }
}
