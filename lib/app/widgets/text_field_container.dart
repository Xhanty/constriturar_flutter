import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: AppColors.lightPrimary,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
