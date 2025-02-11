import 'package:flutter/material.dart';
import 'package:constriturar/app/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Gilroy',
      ),
    );
  }
}