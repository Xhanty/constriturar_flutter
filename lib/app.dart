import 'package:flutter/material.dart';
import 'package:constriturar/app/views/no_connection_page.dart';
import 'package:constriturar/app/views/splash_page.dart';
import 'package:constriturar/app/core/providers/connectivity_provider.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/routes/routes.dart';
import 'package:provider/provider.dart';

// Define una GlobalKey para el Navigator
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Ya no se pasa el context aquí, la navegación se hará vía la key.
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: Consumer<ConnectivityProvider>(
          builder: (context, connectivity, child) {
            return connectivity.isConnected ? SplashPage() : NoConnectionPage();
          },
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Gilroy',
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
