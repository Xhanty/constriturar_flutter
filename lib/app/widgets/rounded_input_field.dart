import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/widgets/widgets.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField(
      {super.key,
      this.hintText,
      this.icon = Icons.person,
      this.type = TextInputType.text,
      this.onTap = _defaultOnTap,
      this.readOnly = false,
      required this.controller});

  final String? hintText;
  final IconData icon;
  final TextInputType type;
  final VoidCallback onTap;
  final bool readOnly;
  final TextEditingController controller;

  static void _defaultOnTap() {}

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.primary,
        keyboardType: type,
        onTap: onTap,
        readOnly: readOnly,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: AppColors.primary,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: 'Gilroy'),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
