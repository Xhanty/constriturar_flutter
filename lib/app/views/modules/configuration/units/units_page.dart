import 'package:flutter/material.dart';
import 'package:constriturar/app/core/services/app/unit_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/widgets/card_simple.dart';
import 'package:constriturar/app/views/modules/configuration/units/units_form.dart';
import 'package:constriturar/app/core/models/unit_model.dart';

class UnitsPage extends StatefulWidget {
  const UnitsPage({super.key});

  @override
  State<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage> {
  final UnitService _unitService = UnitService();
  final TextEditingController _searchController = TextEditingController();
  List<UnitModel> _units = [];
  List<UnitModel> _filteredUnits = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _getUnits();
    _searchController.addListener(_filterUnits);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterUnits);
    _searchController.dispose();
    super.dispose();
  }

  void _getUnits() async {
    final units = await _unitService.getAll();
    if (!mounted) return;
    setState(() {
      _units = units;
      _filteredUnits = units;
      _isLoading = false;
    });
  }

  void _filterUnits() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUnits = _units.where((unit) {
        return unit.unidadDescripcion!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _refreshUnits() {
    setState(() {
      _isLoading = true;
    });
    _getUnits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unidades"),
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
                      hintText: "Buscar unidad",
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
                    itemCount: _filteredUnits.length,
                    itemBuilder: (context, index) {
                      final unit = _filteredUnits[index];
                      return CardSimple(
                        id: unit.unidadId,
                        title: unit.unidadDescripcion!,
                        icon: Icons.straighten,
                        onEdit: (id) async {
                          // final result = await showMaterialModalBottomSheet(
                          //   context: context,
                          //   shape: ShapeBorder.lerp(
                          //     RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(20),
                          //         topRight: Radius.circular(20),
                          //       ),
                          //     ),
                          //     RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(20),
                          //         topRight: Radius.circular(20),
                          //       ),
                          //     ),
                          //     0,
                          //   ),
                          //   builder: (context) {
                          //     return FractionallySizedBox(
                          //       heightFactor: 0.5,
                          //       child: UnitsForm(id: id),
                          //     );
                          //   },
                          // );
                          // if (result == true) {
                          //   _refreshUnits();
                          // }
                        },
                        onDelete: (id) {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       title: const Text("Eliminar unidad"),
                          //       content: const Text(
                          //           "¿Está seguro que desea eliminar esta unidad?"),
                          //       actions: [
                          //         TextButton(
                          //           onPressed: () => Navigator.pop(context),
                          //           child: const Text("Cancelar"),
                          //         ),
                          //         TextButton(
                          //           onPressed: () => Navigator.pop(context),
                          //           child: const Text("Aceptar"),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
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
                child: UnitsForm(),
              );
            },
          );
          if (result == true) {
            _refreshUnits();
          }
        },
        backgroundColor: AppColors.primary,
        tooltip: 'Agregar unidad',
        child: Icon(
          Icons.add,
          color: AppColors.lightPrimary,
        ),
      ),
    );
  }
}
