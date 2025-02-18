import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/widgets/widgets.dart';

class RoundedPasswordField extends StatefulWidget {
  const RoundedPasswordField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  RoundedPasswordFieldState createState() => RoundedPasswordFieldState();
}

class RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.lock,
            color: AppColors.primary,
          ),
          hintText: "Contraseña (*)",
          hintStyle: const TextStyle(fontFamily: 'Gilroy'),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primary,
            ),
            onPressed: _togglePasswordVisibility,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0), // Ajusta este valor según sea necesario
        ),
      ),
    );
  }
}
