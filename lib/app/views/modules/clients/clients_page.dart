import 'package:constriturar/app/views/modules/clients/clients_form.dart';
import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/widgets/card_simple.dart';
import 'package:constriturar/app/core/models/client_model.dart';
import 'package:constriturar/app/core/services/app/client_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final TextEditingController _searchController = TextEditingController();
  final ClientService _clientService = ClientService();
  List<ClientModel> _clients = [];
  List<ClientModel> _filteredClients = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _getClients();
    _searchController.addListener(_filterClients);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterClients);
    _searchController.dispose();
    super.dispose();
  }

  void _getClients() async {
    final clients = await _clientService.getAll();
    if (!mounted) return;
    setState(() {
      _clients = clients;
      _filteredClients = clients;
      _isLoading = false;
    });
  }

  void _filterClients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredClients = _clients.where((client) {
        return client.nombres!.toLowerCase().contains(query) ||
            client.identificacion!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _refreshClients() {
    setState(() {
      _isLoading = true;
    });
    _getClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
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
                      hintText: "Buscar cliente",
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
                    itemCount: _filteredClients.length,
                    itemBuilder: (context, index) {
                      final client = _filteredClients[index];
                      return CardSimple(
                        id: client.clienteId,
                        title: client.nombreCompleto!,
                        description: client.identificacion,
                        icon: Icons.people,
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
                                  body: ClientsForm(id: id),
                                ),
                              );
                            },
                          );
                          if (result == true) {
                            _refreshClients();
                          }
                        },
                        onDelete: (id) => {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Deshabilitar cliente"),
                                content: const Text(
                                    "¿Está seguro que desea deshabilitar este cliente?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await _clientService.disable(client);
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                      _refreshClients();
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
                  body: ClientsForm(),
                ),
              );
            },
          );
          if (result == true) {
            _refreshClients();
          }
        },
        backgroundColor: AppColors.primary,
        tooltip: 'Agregar cliente',
        child: Icon(
          Icons.add,
          color: AppColors.lightPrimary,
        ),
      ),
    );
  }
}
