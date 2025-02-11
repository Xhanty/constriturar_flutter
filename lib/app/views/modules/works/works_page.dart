import 'package:flutter/material.dart';

class WorksPage extends StatelessWidget {
  const WorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Obras")),
      body: const Center(
        child: Text("Página de obras"),
      ),
    );
  }
}
