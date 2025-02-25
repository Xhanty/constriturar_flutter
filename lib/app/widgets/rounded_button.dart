import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      this.press,
      this.backgroundColor = AppColors.primary,
      this.textColor = AppColors.white,
      required this.text});
  final String text;
  final Function()? press;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              letterSpacing: 2,
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Gilroy')),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 17),
      ),
    );
  }
}
