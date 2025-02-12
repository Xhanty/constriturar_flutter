import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/views/modules/configuration/materials/materials_form.dart';
import 'package:constriturar/app/widgets/card_simple.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Materiales"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(11),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar material",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return CardSimple(
                  id: index,
                  title: "Material $index",
                  description: "Descripción del material $index",
                  icon: Icons.ac_unit,
                  onEdit: (id) => {
                    showMaterialModalBottomSheet(
                      context: context,
                      shape: ShapeBorder.lerp(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        0,
                      ),
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.5,
                          child: MaterialsForm(id: id),
                        );
                      },
                    )
                  },
                  onDelete: (id) => {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Eliminar material"),
                          content: const Text(
                              "¿Está seguro que desea eliminar este material?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancelar"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Aceptar"),
                            ),
                          ],
                        );
                      },
                    )
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showMaterialModalBottomSheet(
            context: context,
            shape: ShapeBorder.lerp(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              0,
            ),
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 0.5,
                child: MaterialsForm(),
              );
            },
          )
        },
        backgroundColor: AppColors.primary,
        tooltip: 'Agregar material',
        child: Icon(
          Icons.add,
          color: AppColors.lightPrimary,
        ),
      ),

      // body: const Center(
      //   child: CardSimple(
      //     title: "Material 1",
      //     description: "Descripción del material 1",
      //     icon: Icons.ac_unit,
      //   ),
      // ),
    );
  }
}
