import 'package:flutter/material.dart';
import 'package:constriturar/app/views/auth/login_page.dart';
import 'package:constriturar/app/views/auth/forgot_password_page.dart';
import 'package:constriturar/app/views/modules/home/home_page.dart';
import 'package:constriturar/app/views/modules/profile/profile_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    forgotPassword: (context) => const ForgotPasswordPage(),
    home: (context) => const HomePage(),
    profile: (context) => const ProfilePage(),
  };
}