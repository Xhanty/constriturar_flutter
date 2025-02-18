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
  final TextEditingController _searchController = TextEditingController();
  final MaterialService _materialService = MaterialService();
  List<MaterialModel> _materials = [];
  List<MaterialModel> _filteredMaterials = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _getMaterials();
    _searchController.addListener(_filterMaterials);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterMaterials);
    _searchController.dispose();
    super.dispose();
  }

  void _getMaterials() async {
    final materials = await _materialService.getAll();
    if (!mounted) return;
    setState(() {
      _materials = materials;
      _filteredMaterials = materials;
      _isLoading = false;
    });
  }

  void _filterMaterials() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMaterials = _materials.where((material) {
        return material.materialNombre!.toLowerCase().contains(query) ||
            material.normaTecnica!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _refreshMaterials() {
    setState(() {
      _isLoading = true;
    });
    _getMaterials();
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
                    controller: _searchController,
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
                    itemCount: _filteredMaterials.length,
                    itemBuilder: (context, index) {
                      final material = _filteredMaterials[index];
                      return CardSimple(
                        id: material.materialId,
                        title: material.materialNombre!,
                        description: material.normaTecnica,
                        icon: Icons.cabin,
                        onEdit: (id) async {
                          final result = await showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return FractionallySizedBox(
                                heightFactor: 0.7,
                                child: Scaffold(
                                  resizeToAvoidBottomInset: true,
                                  body: MaterialsForm(id: id),
                                ),
                              );
                            },
                          );
                          if (result == true) {
                            _refreshMaterials();
                          }
                        },
                        onDelete: (id) => {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Deshabilitar material"),
                                content: const Text(
                                    "¿Está seguro que desea deshabilitar este material?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await _materialService.disable(material);
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                      _refreshMaterials();
                                    },
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
        onPressed: () async {
          final result = await showMaterialModalBottomSheet(
            context: context,
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 0.7,
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: MaterialsForm(),
                ),
              );
            },
          );
          if (result == true) {
            _refreshMaterials();
          }
        },
        backgroundColor: AppColors.primary,
        tooltip: 'Agregar material',
        child: Icon(
          Icons.add,
          color: AppColors.lightPrimary,
        ),
      ),
    );
  }
}
