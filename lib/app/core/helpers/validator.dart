import 'package:flutter/material.dart';

class ValidatorHelper {
  final List<TextEditingController> controllers;

  ValidatorHelper(dynamic controller)
      : controllers = controller is TextEditingController
            ? [controller]
            : (controller is List<TextEditingController>
                ? controller
                : throw ArgumentError(
                    'Controller must be TextEditingController or List<TextEditingController>'));

  // Valida si algún campo está vacío
  bool isRequired() {
    return controllers.any((controller) => controller.text.trim().isEmpty);
  }
}
