import 'package:flutter/material.dart';

class VehiclesPage extends StatelessWidget {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vehículos")),
      body: const Center(
        child: Text("Página de Vehículos"),
      ),
    );
  }
}
