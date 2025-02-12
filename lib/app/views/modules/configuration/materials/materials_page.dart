import 'package:flutter/material.dart';
import 'package:constriturar/app/widgets/card_simple.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Materiales")),
      body: const Center(
        child: CardSimple(
          title: "Material 1",
          description: "Descripción del material 1",
          icon: Icons.ac_unit,
        ),
      ),
    );
  }
}
