import 'package:flutter/material.dart';
import 'package:constriturar/app/views/modules/works/works_form.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/core/models/work_model.dart';
import 'package:constriturar/app/core/services/app/work_service.dart';
import 'package:constriturar/app/widgets/card_simple.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class WorksPage extends StatefulWidget {
  const WorksPage({super.key});

  @override
  State<WorksPage> createState() => _WorksPageState();
}

class _WorksPageState extends State<WorksPage> {
  final TextEditingController _searchController = TextEditingController();
  final WorkService _workService = WorkService();
  List<WorkModel> _works = [];
  List<WorkModel> _filteredWorks = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _getWorks();
    _searchController.addListener(_filterWorks);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterWorks);
    _searchController.dispose();
    super.dispose();
  }

  void _getWorks() async {
    final works = await _workService.getAll();
    if (!mounted) return;
    setState(() {
      _works = works;
      _filteredWorks = works;
      _isLoading = false;
    });
  }

  void _filterWorks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredWorks = _works.where((work) {
        return work.obraNombre!.toLowerCase().contains(query) ||
            work.ubicacion!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _refreshWorks() {
    setState(() {
      _isLoading = true;
    });
    _getWorks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Obras"),
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
                      hintText: "Buscar obra",
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
                    itemCount: _filteredWorks.length,
                    itemBuilder: (context, index) {
                      final work = _filteredWorks[index];
                      return CardSimple(
                        id: work.obraId,
                        title: work.obraNombre!,
                        description: work.ubicacion,
                        icon: Icons.construction,
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
                                heightFactor: 0.9,
                                child: Scaffold(
                                  resizeToAvoidBottomInset: true,
                                  body: WorksForm(id: id),
                                ),
                              );
                            },
                          );
                          if (result == true) {
                            _refreshWorks();
                          }
                        },
                        onDelete: (id) => {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Deshabilitar obra"),
                                content: const Text(
                                    "¿Está seguro que desea deshabilitar esta obra?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await _workService.disable(work);
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                      _refreshWorks();
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
                heightFactor: 0.9,
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: WorksForm(),
                ),
              );
            },
          );
          if (result == true) {
            _refreshWorks();
          }
        },
        backgroundColor: AppColors.primary,
        tooltip: 'Agregar obra',
        child: Icon(
          Icons.add,
          color: AppColors.lightPrimary,
        ),
      ),
    );
  }
}
