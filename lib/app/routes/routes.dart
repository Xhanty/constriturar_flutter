import 'package:flutter/material.dart';
import 'package:constriturar/app/views/modules/home/home_page.dart';
import 'package:constriturar/app/views/auth/login_page.dart';
import 'package:constriturar/app/views/auth/forgot_password_page.dart';
import 'package:constriturar/app/views/modules/profile/profile_page.dart';
import 'package:constriturar/app/views/main_pages.dart';

class AppRoutes {
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String profile = '/profile';

  static const String mainPages = '/main-pages';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    forgotPassword: (context) => const ForgotPasswordPage(),
    profile: (context) => const ProfilePage(),

    mainPages: (context) => const MainPage(child: HomePage()),
  };
}