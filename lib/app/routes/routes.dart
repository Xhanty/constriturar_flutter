import 'package:flutter/material.dart';
import 'package:constriturar/app/views/splash_page.dart';
import 'package:constriturar/app/views/auth/login_page.dart';
import 'package:constriturar/app/views/auth/forgot_password_page.dart';
import 'package:constriturar/app/views/modules/profile/profile_page.dart';
import 'package:constriturar/app/views/main_pages.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashPage(),
    login: (context) => const LoginPage(),
    forgotPassword: (context) => const ForgotPasswordPage(),
    profile: (context) => const ProfilePage(),
  };

  static setView<Void>(Widget view, BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainPage(child: view)),
        (route) => false);
  }
}
