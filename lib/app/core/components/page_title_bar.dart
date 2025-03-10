import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';

class PageTitleBar extends StatelessWidget {
  const PageTitleBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      decoration: const BoxDecoration(
        color: AppColors.lightPrimary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: AppColors.black),
        ),
      ),
    );
  }
}
