import 'package:flutter/material.dart';

class UnitsPage extends StatelessWidget {
  const UnitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Listado de CRUD")),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Item $index"),
            onTap: () {
              // Navegar a editar
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a crear
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
