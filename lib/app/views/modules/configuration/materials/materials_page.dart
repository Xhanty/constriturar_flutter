import 'package:flutter/material.dart';
import 'package:constriturar/app/core/models/material_model.dart';
import 'package:constriturar/app/core/services/app/material_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/views/modules/configuration/materials/materials_form.dart';
import 'package:constriturar/app/widgets/card_simple.dart';

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({super.key});

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  final MaterialService _materialService = MaterialService();
  List<MaterialModel> _materials = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _getUnits();
  }

  void _getUnits() async {
    final materials = await _materialService.getAll();
    if (!mounted) return;
    setState(() {
      _materials = materials;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Materiales"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                    itemCount: _materials.length,
                    itemBuilder: (context, index) {
                      final material = _materials[index];
                      return CardSimple(
                        id: material.materialId,
                        title: material.materialNombre,
                        description: material.normaTecnica,
                        icon: Icons.cabin,
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
                                heightFactor: 0.6,
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
                heightFactor: 0.6,
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
