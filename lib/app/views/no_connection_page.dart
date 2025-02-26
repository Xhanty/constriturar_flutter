import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:constriturar/app/core/config/app_colors.dart';

class NoConnectionPage extends StatefulWidget {
  const NoConnectionPage({super.key});

  @override
  State<NoConnectionPage> createState() => _NoConnectionPageState();
}

class _NoConnectionPageState extends State<NoConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Lottie.asset(
                    'assets/animations/no_wifi.json',
                  ),
                ),
                Text(
                  'No hay conexión a internet',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Recuerda que cuando tengas conexión, volverás al inicio automáticamente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
