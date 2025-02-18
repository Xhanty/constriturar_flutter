import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/views/modules/users/users_form.dart';
import 'package:constriturar/app/widgets/card_simple.dart';
import 'package:constriturar/app/core/services/app/user_service.dart';
import 'package:constriturar/app/core/models/user_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final TextEditingController _searchController = TextEditingController();
  final UserService _userService = UserService();
  List<UserModel> _users = [];
  List<UserModel> _filteredUsers = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _getUsers();
    _searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterUsers);
    _searchController.dispose();
    super.dispose();
  }

  void _getUsers() async {
    final users = await _userService.getAll();
    if (!mounted) return;
    setState(() {
      _users = users;
      _filteredUsers = users;
      _isLoading = false;
    });
  }

  void _filterUsers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _users.where((user) {
        return user.userName!.toLowerCase().contains(query) ||
            user.email!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _refreshUsers() {
    setState(() {
      _isLoading = true;
    });
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Usuarios")),
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
                      hintText: "Buscar usuario",
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
                    itemCount: _filteredUsers.length,
                    itemBuilder: (context, index) {
                      final usuario = _filteredUsers[index];
                      return CardSimple(
                        id: usuario.id,
                        title: usuario.userName!,
                        description: usuario.email,
                        icon: Icons.person_search,
                        backgroundColor: usuario.estado == 'I'
                            ? AppColors.dangerLight
                            : AppColors.white,
                        onEdit: (id) async {
                          // final result = await showMaterialModalBottomSheet(
                          //   context: context,
                          //   builder: (context) {
                          //     return FractionallySizedBox(
                          //       heightFactor: 0.7,
                          //       child: Scaffold(
                          //         resizeToAvoidBottomInset: true,
                          //         body: UsersForm(id: id),
                          //       ),
                          //     );
                          //   },
                          // );
                          // if (result == true) {
                          //   _refreshUsers();
                          // }
                        },
                        onDelete: (id) => {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Deshabilitar usuario"),
                                content: const Text(
                                    "¿Está seguro que desea deshabilitar este usuario?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await _userService.disable(usuario);
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                      _refreshUsers();
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
                  body: UsersForm(),
                ),
              );
            },
          );
          if (result == true) {
            _refreshUsers();
          }
        },
        backgroundColor: AppColors.primary,
        tooltip: 'Agregar usuario',
        child: Icon(
          Icons.add,
          color: AppColors.lightPrimary,
        ),
      ),
    );
  }
}
