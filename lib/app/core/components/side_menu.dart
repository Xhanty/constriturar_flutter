import 'package:flutter/material.dart';
import 'package:constriturar/app/core/services/auth_service.dart';
import 'package:constriturar/app/routes/routes.dart';
import 'package:constriturar/app/core/config/app_colors.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 288,
      height: double.infinity,
      color: AppColors.primary,
      child: SafeArea(
        child: Column(
          children: [
            InfoCard(name: 'Santiago Henao', role: 'Administrador'),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 5, bottom: 5),
            ),
            SideMenuOptions(authService: _authService)
          ],
        ),
      ),
    ));
  }
}

class SideMenuOptions extends StatelessWidget {
  const SideMenuOptions({
    super.key,
    required this.authService,
  });

  final AuthService authService;
  final List<Map<String, dynamic>> menuItems = const [
    {
      'icon': Icons.home,
      'title': 'Inicio',
      'route': AppRoutes.mainPages,
      'label': 'Dashboard',
      'isVisible': true
    },
    {
      'icon': Icons.people,
      'title': 'Clientes',
      'route': AppRoutes.mainPages,
      'label': 'Clients',
      'isVisible': true
    },
    {
      'icon': Icons.cabin,
      'title': 'Materiales',
      'route': AppRoutes.mainPages,
      'label': 'Materials',
      'isVisible': true
    },
    {
      'icon': Icons.construction,
      'title': 'Obras',
      'route': AppRoutes.mainPages,
      'label': 'Projects',
      'isVisible': true
    },
    {
      'icon': Icons.person_search,
      'title': 'Usuarios',
      'route': AppRoutes.mainPages,
      'label': 'Users',
      'isVisible': true
    },
    {
      'icon': Icons.straighten,
      'title': 'Unidades',
      'route': AppRoutes.mainPages,
      'label': 'Units',
      'isVisible': true
    },
    {
      'icon': Icons.directions_car,
      'title': 'Vehículos',
      'route': AppRoutes.mainPages,
      'label': 'Vehicles',
      'isVisible': true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...menuItems.where((item) => item['isVisible']).map((item) {
          return ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, item['route']);
            },
            leading: SizedBox(
              height: 34,
              width: 34,
              child: Icon(item['icon'], color: AppColors.lightPrimary),
            ),
            title: Text(
              item['title'],
              style: TextStyle(color: AppColors.lightPrimary),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 16),
          child: Divider(
            color: AppColors.lightPrimary,
            height: 1,
          ),
        ),
        ListTile(
          onTap: () {
            // Eliminar los tokens del almacenamiento seguro
            authService.logout();
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          },
          leading: SizedBox(
            height: 34,
            width: 34,
            child: Icon(Icons.logout, color: AppColors.lightPrimary),
          ),
          title: Text(
            'Cerrar sesión',
            style: TextStyle(color: AppColors.lightPrimary),
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.role,
  });

  final String name, role;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.lightPrimary,
        child: Icon(Icons.person, color: AppColors.primary),
      ),
      title: Text(
        name,
        style: TextStyle(color: AppColors.lightPrimary),
      ),
      subtitle: Text(role, style: TextStyle(color: AppColors.lightPrimary)),
    );
  }
}
