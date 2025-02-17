import 'package:constriturar/app/views/modules/configuration/vehicles/vehicles_form.dart';
import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/widgets/card_simple.dart';
import 'package:constriturar/app/core/models/vehicle_model.dart';
import 'package:constriturar/app/core/services/app/vehicle_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({super.key});

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  final TextEditingController _searchController = TextEditingController();
  final VehicleService _vehicleService = VehicleService();
  List<VehicleModel> _vehicles = [];
  List<VehicleModel> _filteredVechicles = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _getVehicles();
    _searchController.addListener(_filterVechicles);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterVechicles);
    _searchController.dispose();
    super.dispose();
  }

  void _getVehicles() async {
    final materials = await _vehicleService.getAll();
    if (!mounted) return;
    setState(() {
      _vehicles = materials;
      _filteredVechicles = materials;
      _isLoading = false;
    });
  }

  void _filterVechicles() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredVechicles = _vehicles.where((vehicle) {
        return vehicle.vehiculoDescripcion!.toLowerCase().contains(query) ||
            vehicle.placa!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _refreshVehicles() {
    setState(() {
      _isLoading = true;
    });
    _getVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehículos"),
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
                      hintText: "Buscar vehículo",
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
                    itemCount: _filteredVechicles.length,
                    itemBuilder: (context, index) {
                      final vehicle = _filteredVechicles[index];
                      return CardSimple(
                        id: vehicle.vehiculoId,
                        title: vehicle.vehiculoDescripcion!,
                        description: vehicle.placa,
                        icon: Icons.directions_car,
                        onEdit: (id) async {
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
                                heightFactor: 0.7,
                                child: VehiclesForm(id: id),
                              );
                            },
                          );
                          if (result == true) {
                            _refreshVehicles();
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
                                      await _vehicleService.disable(vehicle);
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                      _refreshVehicles();
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
                heightFactor: 0.7,
                child: VehiclesForm(),
              );
            },
          );
          if (result == true) {
            _refreshVehicles();
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
